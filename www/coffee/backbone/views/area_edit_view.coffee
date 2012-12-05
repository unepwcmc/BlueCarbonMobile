window.BlueCarbon ||= {}
window.BlueCarbon.Views ||= {}

class BlueCarbon.Views.AreaEditView extends Backbone.View
  template: JST['area/edit']
  events :
    "touchstart #new-validation" : "fireAddValidation"
    "touchstart .ios-head .back" : "fireBack"

  initialize: (options) ->
    @area = options.area
  
  fireAddValidation: ->
    @trigger('addValidation', area: @area)

  fireBack: ->
    @trigger('back')

  render: ->
    @$el.html(@template(area: @area))
    return @
