window.BlueCarbon ||= {}
window.BlueCarbon.Models ||= {}

class BlueCarbon.Models.Validation extends Backbone.SyncableModel
  url: 'http://bluecarbon.unep-wcmc.org/validations.json'

  schema: ->
    "coordinates TEXT, action TEXT, area_id INTEGER, user_id INTEGER, knowledge TEXT, density TEXT, age TEXT, habitat TEXT, name TEXT, row_id INTEGER PRIMARY KEY"

  toJSON: (forRails = true)->
    json = super
    if forRails
      return {
        validation: json
      }
    else
      return json

  setGeomFromPoints: (points) ->
    points = for point in points
      [point.lng, point.lat]

    points.push points[0]

    @set('coordinates', [[points]])

  geomAsLatLngArray: () ->
    latLngs = []

    for point in @get('coordinates')[0][0]
      latLngs.push(new L.LatLng(point[1], point[0]))

    return latLngs
