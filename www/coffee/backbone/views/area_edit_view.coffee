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
    navigator.geolocation.getCurrentPosition(@drawLocation, {}, {enableHighAccuracy: true})

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

    #radius = position.coords.accuracy / 2
    #@accuracyMarker = L.circle(latlng, radius).addTo(@map)

  uploadValidations: ->
    @validationList.pushToServer()

  render: =>
    @$el.html(@template(area: @area, validationCount: @validationList.models.length)).promise().done(@drawSubViews)

    return @

  drawSubViews: =>
    @closeSubViews()
    @validationList.each (validation)=>
      validationView = new BlueCarbon.Views.ValidationView(validation:validation)
      @subViews.push validationView
      $('#validation-list').append(validationView.render().el)

  onClose: =>
    @validationList.off('reset', @render)
    @closeSubViews()
    @removeTileLayers(@map)
    @removeLayerControl(@map)
    @stopLocating()

  closeSubViews: ->
    while (view = @subViews.pop())?
      view.close()

_.extend(BlueCarbon.Views.AreaEditView::, BlueCarbon.Mixins.AreaMapLayers)
