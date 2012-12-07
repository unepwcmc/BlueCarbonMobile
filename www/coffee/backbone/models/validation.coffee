window.BlueCarbon ||= {}
window.BlueCarbon.Models ||= {}

class BlueCarbon.Models.Validation extends Backbone.SyncableModel
  schema: ->
    "geometry TEXT, type TEXT, area_id INTEGER, user_id INTEGER"

  setGeomFromPoints: (points) ->
    points = for point in points
      [point.lng, point.lat]

    points.push points[0]

    @set('geometry', [[points]])

  geomAsLatLngArray: () ->
    latLngs = []

    for point in @get('geometry')[0][0]
      latLngs.push(new L.LatLng(point[1], point[0]))

    return latLngs
  
  parse: (data) ->
    if data.geometry?
      data.geometry = JSON.parse(data.geometry)
    super
