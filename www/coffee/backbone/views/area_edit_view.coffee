window.BlueCarbon ||= {}
window.BlueCarbon.Views ||= {}

class BlueCarbon.Views.AreaEditView extends Backbone.View
  template: JST['area/edit']
  events :
    "touchstart #new-validation" : "fireAddValidation"
    "touchstart .ios-head .back" : "fireBack"

  initialize: (options) ->
    @area = options.area
    @validationList = new BlueCarbon.Collections.Validations(area: @area)
    @validationList.on('reset', @render)
    @validationList.localFetch()
  
  fireAddValidation: ->
    @trigger('addValidation', area: @area)

  fireBack: ->
    @trigger('back')

  render: =>
    @$el.html(@template(area: @area))
    @validationList.each (validation)=>
      $('#validation-list').append(new BlueCarbon.Views.ValidationView(validation:validation).render().el)
    return @
