window.BlueCarbon ||= {}
window.BlueCarbon.Views ||= {}

class BlueCarbon.Views.AreaEditView extends Backbone.View
  template: JST['area/edit']
  events :
    "touchstart #new-polygon" : "fireAddPolygon"
  
  fireAddPolygon: ->
    @trigger('addPolygon')

  render: ->
    console.log(@template())
    @$el.html(@template())
    return @
