window.BlueCarbon ||= {}
window.BlueCarbon.Models ||= {}

class BlueCarbon.Models.Validation extends Backbone.Model
  setGeomFromPoints: (points) ->
    points = for point in points
      [point.lng, point.lat]

    points.push points[0]

    @set('geometry', [[points]])
