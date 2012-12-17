window.BlueCarbon ||= {}
window.BlueCarbon.Views ||= {}

class BlueCarbon.Views.AreaEditView extends Backbone.View
  template: JST['area/edit']
  events :
    "touchstart #new-validation" : "fireAddValidation"
    "touchstart #upload-validations" : "uploadValidations"
    "touchstart .ios-head .back" : "fireBack"

  initialize: (options) ->
    @area = options.area
    @map = options.map
    @validationList = new BlueCarbon.Collections.Validations([], area: @area)
    @validationList.on('reset', @render)
    @validationList.localFetch()

    @subViews = []

  fireAddValidation: ->
    @trigger('addValidation', area: @area)

  fireBack: ->
    @trigger('back')

  uploadValidations: ->
    @validationList.pushToServer()

  render: =>
    @$el.html(@template(area: @area, validationCount: @validationList.models.length))
    @validationList.each (validation)=>
      validationView =  new BlueCarbon.Views.ValidationView(validation:validation)
      $('#validation-list').append(validationView.render().el)
      @subViews.push validationView
    @addMapLayers(@area, @map)
    return @

  onClose: ->
    for view in @subViews
      view.close()
    @removeTileLayers(@map)

_.extend(BlueCarbon.Views.AreaEditView::, BlueCarbon.Mixins.AreaMapLayers)
