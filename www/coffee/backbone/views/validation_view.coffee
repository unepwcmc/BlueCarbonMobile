window.BlueCarbon ||= {}
window.BlueCarbon.Views ||= {}

class BlueCarbon.Views.ValidationView extends Backbone.View
  template: JST['area/validation']
  tagName: 'li'
  events:
    "click .delete-validation" : "delete"

  initialize: (options)->
    @validation = options.validation
    @validation.on('destroy', =>
      @close()
    )
    @map = window.blueCarbonApp.map
    polyOptions = {}
    if @validation.get('action') == 'delete'
      polyOptions =
        color: "#FF0000"
        strokeColor: "#FF0000"
    @mapPolygon = new L.Polygon(@validation.geomAsLatLngArray(), polyOptions)

  render: =>
    @$el.html(@template(validation:@validation))
    @mapPolygon.addTo(@map)
    return @

  delete: =>
    @validation.localDestroy()

  onClose: ->
    @map.removeLayer(@mapPolygon)

