window.BlueCarbon ||= {}
window.BlueCarbon.Models ||= {}

class BlueCarbon.Models.Validation extends Backbone.SyncableModel
  url: 'http://bluecarbon.unep-wcmc.org/validations.json'

  schema: ->
    "sqlite_id INTEGER PRIMARY KEY, id INTEGER, coordinates TEXT, action TEXT, area_id INTEGER, user_id INTEGER, density TEXT, age TEXT, habitat TEXT, condition TEXT, species TEXT, recorded_at TEXT, notes TEXT"

  name: ->
    return "#{ @get('habitat') } - #{@get('action') } ( #{@get('recorded_at').replace(/-/g, '/')})"
    
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

    @set('coordinates', points)

  geomAsLatLngArray: () ->
    latLngs = []

    for point in @get('coordinates')
      latLngs.push(new L.LatLng(point[1], point[0]))

    return latLngs
