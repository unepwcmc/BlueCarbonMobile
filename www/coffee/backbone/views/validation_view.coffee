window.BlueCarbon ||= {}
window.BlueCarbon.Views ||= {}

class BlueCarbon.Views.ValidationView extends Backbone.View
  template: JST['area/validation']
  tagName: 'li'
  initialize: (options)->
    @validation = options.validation

  render: =>
    @$el.html(@template(validation:@validation))
    return @
