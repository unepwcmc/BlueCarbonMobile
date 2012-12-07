window.BlueCarbon ||= {}
window.BlueCarbon.Views ||= {}

class BlueCarbon.Views.ValidationView extends Backbone.View
  template: JST['area/validation']
  tagName: 'li'
  initialize: (options)->
    @validation = options.validation
    @map = window.blueCarbonApp.map
    @mapPolygon = new L.Polygon(@validation.geomAsLatLngArray())

  render: =>
    @$el.html(@template(validation:@validation))
    @mapPolygon.addTo(@map)
    return @

  onClose: ->
    @map.removeLayer(@mapPolygon)

