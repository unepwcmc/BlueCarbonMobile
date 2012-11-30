window.BlueCarbon ||= {}
window.BlueCarbon.Views ||= {}

class BlueCarbon.Views.AddValidationView extends Backbone.View
  initialize: (options)->
    @map = options.map
