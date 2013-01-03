window.BlueCarbon ||= {}
window.BlueCarbon.Views ||= {}

class BlueCarbon.Views.AreaEditView extends Backbone.View
  template: JST['area/edit']
  events :
    "touchend #new-validation" : "fireAddValidation"
    "touchend #upload-validations" : "uploadValidations"
    "touchend .ios-head .back" : "fireBack"

  initialize: (options) ->
    @area = options.area
    @map = options.map
    @validationList = new BlueCarbon.Collections.Validations([], area: @area)
    @validationList.on('reset', @render)
    @validationList.localFetch()

    @subViews = []

    @addMapLayers(@area, @map)
    @addLayerControl(@map)
    @startLocating()

  fireAddValidation: ->
    @trigger('addValidation', area: @area)

  fireBack: ->
    @trigger('back')

  startLocating: () ->
    unless @geoWatchId?
      @getPosition()
      @geoWatchId = setInterval(@getPosition, 30000)

  getPosition: () =>
    navigator.geolocation.getCurrentPosition(@drawLocation, (->
      console.log("unable to get current location: #{arguments}")
    ), {enableHighAccuracy: true})

  stopLocating: () ->
    if @geoWatchId?
      clearInterval(@geoWatchId)
      @geoWatchId = null

    if @marker?
      @map.removeLayer(@marker)

    if @accuracyMarker?
      @map.removeLayer(@accuracyMarker)

  drawLocation: (position) =>
    if @marker?
      @map.removeLayer(@marker)

    #if @accuracyMarker?
      #@map.removeLayer(@accuracyMarker)

    GpsIcon = L.Icon.extend(
      options:
        iconUrl: 'css/images/gps-marker.png'
        iconSize: [16, 16]
    )

    gpsIcon = new GpsIcon()

    latlng = [
      position.coords.latitude,
      position.coords.longitude
    ]

    @marker = L.marker(latlng, {icon: gpsIcon}).addTo(@map)

  uploadValidations: ->
    @uploading = true
    @render()
    @validationList.pushToServer(
      @showSuccessfulUploadNotice,
      @showUploadErrors
    )

  showSuccessfulUploadNotice: (validations)=>
    alert("""
      Successfully pushed #{validations.length} validation(s) to server.
      You will need to re-download the habitat data for this area before making more edits
    """)
    @trigger('back')

  showUploadErrors: (errors)=>
    @uploading = false
    @render()
    errorText = ""
    for validationError in errors
      errorText += "<li>Failed to upload '#{validationError.validation.name()}'</li>"
    @$el.append("<div class='error-notice'><ul>#{errorText}</ul></div>")

  render: =>
    @$el.html(@template(area: @area, validationCount: @validationList.models.length, uploading: @uploading))
    @drawSubViews()

    return @

  drawSubViews: =>
    if $('#validation-list').length > 0
      @closeSubViews()
      @validationList.each (validation)=>
        validationView = new BlueCarbon.Views.ValidationView(validation:validation)
        @subViews.push validationView
        $('#validation-list').append(validationView.render().el)
    else
      # If #validation-list hasn't been inserted yet, listen to DOM changes for when it is
      @validationListObserver = new WebKitMutationObserver((mutations, observer) =>
        # fired when a DOM mutation occurs
        # Try this method again, to see if #validation-list exists yet
        @drawSubViews()
        observer.disconnect()
      )
      @validationListObserver.observe(document, 
        subtree: true
        childList: true
      )

  onClose: =>
    @validationList.off('reset', @render)
    @closeSubViews()
    @validationListObserver.disconnect() if @validationListObserver
    @removeTileLayers(@map)
    @removeLayerControl(@map)
    @stopLocating()

  closeSubViews: ->
    while (view = @subViews.pop())?
      view.close()

_.extend(BlueCarbon.Views.AreaEditView::, BlueCarbon.Mixins.AreaMapLayers)
