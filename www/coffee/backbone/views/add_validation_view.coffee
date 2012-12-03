window.BlueCarbon ||= {}
window.BlueCarbon.Views ||= {}

class BlueCarbon.Views.AddValidationView extends Backbone.View
  template: JST['area/add_polygon']
  events:
    "touchstart #create-polygon": 'createPolygon'
  initialize: (options)->
    @map = options.map

    @validation = new BlueCarbon.Models.Validation()

    @map.on 'draw:poly-created', (e) =>
      @validation.setGeomFromPoints(e.poly.getLatLngs())

  render: () ->
    # Turn on Leaflet.draw polygon tool
    @polygonDraw = new L.Polygon.Draw(@map, {})
    @polygonDraw.enable()

    @$el.html(@template())
    return @

  createPolygon: () =>
    unless @validation.get('geometry')?
      alert("You've not finished your polygon!")
      return false
    alert("Implement persistence plx")

  close: () ->
    @polygonDraw.disable()
    @map.off('draw:poly-created')

