window.BlueCarbon ||= {}
window.BlueCarbon.Views ||= {}

class BlueCarbon.Views.LoginView extends Backbone.View
  template: JST['area/login']

  render: ->
    @$el.html(@template())
    return @
