window.BlueCarbon ||= {}
window.BlueCarbon.Views ||= {}

class BlueCarbon.Views.AreaEditView extends Backbone.View
  template: JST['area/edit']
  events :
    "touchstart #new-validation" : "fireAddValidation"
    "touchstart #upload-validations" : "uploadValidations"
    "touchstart .ios-head .back" : "fireBack"

  initialize: (options) ->
    @area = options.area
    @map = options.map
    @validationList = new BlueCarbon.Collections.Validations([], area: @area)
    @validationList.on('reset', @render)
    @validationList.localFetch()

    @subViews = []

    @startLocating()

  fireAddValidation: ->
    @trigger('addValidation', area: @area)

  fireBack: ->
    @trigger('back')

  startLocating: (options) ->
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

    if @accuracyMarker?
      @map.removeLayer(@accuracyMarker)

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

    radius = position.coords.accuracy / 2
    @accuracyMarker = L.circle(latlng, radius).addTo(@map)

  uploadValidations: ->
    @validationList.pushToServer()

  render: =>
    @$el.html(@template(area: @area, validationCount: @validationList.models.length))
    @validationList.each (validation)=>
      validationView =  new BlueCarbon.Views.ValidationView(validation:validation)
      $('#validation-list').append(validationView.render().el)
      @subViews.push validationView

    @addMapLayers(@area, @map)
    @startLocating(@map)

    return @

  onClose: ->
    for view in @subViews
      view.close()
    @removeTileLayers(@map)
    @stopLocating()

_.extend(BlueCarbon.Views.AreaEditView::, BlueCarbon.Mixins.AreaMapLayers)
