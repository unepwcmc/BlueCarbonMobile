window.BlueCarbon ||= {}
window.BlueCarbon.Views ||= {}

class BlueCarbon.Views.AreaIndexView extends Backbone.View
  template: JST['area/area_index']
  className: 'area-index'
  initialize: ->
    @areaList = new BlueCarbon.Collections.Areas()
    @areaList.on('reset', @render)
    @areaList.localFetch(
      success: =>
        @areaList.fetch()
    )
    

    @subViews = []

  render: =>
    @$el.html(@template(models:@areaList.toJSON()))
    @areaList.each (area)=>
      areaView = new BlueCarbon.Views.AreaView(area:area)
      $('#area-list').append(areaView.render().el)
      @subViews.push areaView
    return @

  onClose: ->
    for view in @subViews
      view.close()

class BlueCarbon.Views.AreaView extends Backbone.View
  template: JST['area/area']
  tagName: 'li'
  events:
    "touchstart .start-trip": "startTrip"
  initialize: (options)->
    @area = options.area

  render: =>
    @$el.html(@template(area:@area))
    return @

  startTrip: =>
    BlueCarbon.bus.trigger('area:startTrip', area: @area)
