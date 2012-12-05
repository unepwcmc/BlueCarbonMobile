window.BlueCarbon ||= {}
window.BlueCarbon.Views ||= {}

class BlueCarbon.Views.AreaEditView extends Backbone.View
  template: JST['area/edit']
  events :
    "touchstart #new-validation" : "fireAddValidation"
  initialize: (options) ->
    @area = options.area
  
  fireAddValidation: ->
    @trigger('addValidation', area: @area)

  render: ->
    @$el.html(@template(area: @area))
    return @
