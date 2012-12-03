window.BlueCarbon ||= {}
window.BlueCarbon.Views ||= {}

class BlueCarbon.Views.AddValidationView extends Backbone.View
  template: JST['area/add_polygon']
  initialize: (options)->
    @map = options.map

    @polygonDrawn =  false
    @map.on 'draw:poly-created', (e) =>
      mapPolygon = e.poly
      @polygonDrawn =  false

  render: () ->
    # Turn on Leaflet.draw polygon tool
    @polygonDraw = new L.Polygon.Draw(@map, {})
    @polygonDraw.enable()

    @$el.html(@template())
    return @

  createPolygon: (mapPolygon) ->
    @polygon.setGeomFromPoints(mapPolygon.getLatLngs())
    @polygon.save(success: () =>
      @close()
      @finishedCallback() if finishedCallback?
    )

  close: () ->
    @polygonDraw.disable()
    Pica.config.map.off('draw:poly-created')

