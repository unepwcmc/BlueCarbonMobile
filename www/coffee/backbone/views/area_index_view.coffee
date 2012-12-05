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
    @areaList.each (area)=>
      $('#area-list').append(new BlueCarbon.Views.AreaView(area:area).render().el)
    return @

class BlueCarbon.Views.AreaView extends Backbone.View
  template: JST['area/area']
  events:
    "touchstart .start-trip": "startTrip"
  initialize: (options)->
    @area = options.area

  render: =>
    @$el.html(@template(area:@area))
    return @

  startTrip: =>
    BlueCarbon.bus.trigger('area:startTrip', area: @area)
