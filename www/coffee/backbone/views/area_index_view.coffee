window.BlueCarbon ||= {}
window.BlueCarbon.Views ||= {}

class BlueCarbon.Views.AreaIndexView extends Backbone.View
  template: JST['area/area_index']
  className: 'area-index'
  initialize: (options) ->
    @map = options.map
    @areaList = new BlueCarbon.Collections.Areas()
    @areaList.on('reset', @render)
    @areaList.localFetch(
      success: =>
        @showUpdating()
        @areaList.fetch(
          success: =>
            @areaList.localSave() # Write updated list to DB
            @showUpdated()
        )
      error: (a,b,c)=>
        console.log "local fetch fail:"
        console.log arguments
        console.log arguments[0].stack
    )

    @subViews = []

  render: =>
    @$el.html(@template(models:@areaList.toJSON()))
    @areaList.each (area)=>
      areaView = new BlueCarbon.Views.AreaView(area:area, map: @map)
      $('#area-list').append(areaView.render().el)
      @subViews.push areaView
    return @

  showUpdating: ->
    $('#sync-status').text("Syncing area list...")

  showUpdated: ->
    $('#sync-status').text("Area list updated")

  onClose: ->
    for view in @subViews
      view.close()

class BlueCarbon.Views.AreaView extends Backbone.View
  template: JST['area/area']
  tagName: 'li'
  events:
    "touchstart .download-data": "downloadData"
    "touchstart .start-trip": "startTrip"

  initialize: (options)->
    @area = options.area
    @area.on('sync', @render)
    @map = options.map

  render: =>
    @$el.html(@template(area:@area))
    @map.removeLayer(@mapPolygon) if @mapPolygon?
    @mapPolygon = new L.rectangle(@area.coordsAsLatLngArray())
    @mapPolygon.addTo(@map)

    return @

  startTrip: =>
    BlueCarbon.bus.trigger('area:startTrip', area: @area)

  downloadData: =>
    @area.downloadData()
    @render()

  onClose: ->
    @map.removeLayer(@mapPolygon)
