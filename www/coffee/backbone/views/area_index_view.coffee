window.BlueCarbon ||= {}
window.BlueCarbon.Views ||= {}

class BlueCarbon.Views.AreaIndexView extends Backbone.View
  template: JST['area/area_index']
  className: 'area-index'
  initialize: ->
    @areaList = new BlueCarbon.Collections.Areas()
    @areaList.on('reset', @render)
    @areaList.fetch()

  render: =>
    @$el.html(@template(models:@areaList.toJSON()))
    return @
