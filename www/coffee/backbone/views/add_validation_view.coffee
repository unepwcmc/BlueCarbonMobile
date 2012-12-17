window.BlueCarbon ||= {}
window.BlueCarbon.Views ||= {}

class BlueCarbon.Views.AddValidationView extends Backbone.View
  template: JST['area/add_polygon']
  events:
    "touchstart #create-analysis": 'createAnalysis'
    "touchstart .ios-head .back" : "fireBack"

  initialize: (options)->
    @area = options.area
    @map = options.map

    @validation = new BlueCarbon.Models.Validation()

    @map.on 'draw:poly-created', (e) =>
      @validation.setGeomFromPoints(e.poly.getLatLngs())
      @mapPolygon = new L.Polygon(e.poly.getLatLngs())
      @mapPolygon.addTo(@map)

  render: () ->
    # Turn on Leaflet.draw polygon tool
    @polygonDraw = new L.Polygon.Draw(@map, {})
    @polygonDraw.enable()

    @$el.html(@template(area: @area))
    @addMapLayers(@area, @map)
    @addLayerControl(@map)
    return @

  createAnalysis: () =>
    unless @validation.get('geometry')?
      alert("You've not finished your polygon!")
      return false
    @validation.set($('form#validation-attributes').serializeObject())
    @validation.localSave(@validation.attributes,
      success: =>
        console.log 'successfully saved:'
        console.log @validation
        @trigger('validation:created', area: @area)
      error: (a,b,c)=>
        console.log 'error saving validation:'
        console.log arguments
    )

  fireBack: ->
    @trigger('back', area: @area)

  close: () ->
    @polygonDraw.disable()
    @map.off('draw:poly-created')
    @map.removeLayer(@mapPolygon) if @mapPolygon?
    @removeTileLayers(@map)

_.extend(BlueCarbon.Views.AddValidationView::, BlueCarbon.Mixins.AreaMapLayers)
