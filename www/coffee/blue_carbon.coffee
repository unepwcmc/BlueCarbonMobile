window.onerror = (message, url, linenumber) ->
  console.log "JavaScript error: #{message} on line #{linenumber} for #{url}"
  alert "JavaScript error: #{message} on line #{linenumber} for #{url}"

$.support.cors = true
$.ajaxSetup(
  data:
    auth_token: ''
)

window.Wcmc ||= {}
window.BlueCarbon ||= {}
window.BlueCarbon.bus = _.extend({}, Backbone.Events)
window.BlueCarbon.Models ||= {}
window.BlueCarbon.Controllers ||= {}
window.BlueCarbon.Views ||= {}
window.BlueCarbon.Routers ||= {}

class BlueCarbon.App
  _.extend @::, Backbone.Events

  # Application Constructor
  constructor: (options)->

    @on('mapReady', =>
      @controller = new BlueCarbon.Controller(app:@)
    )

    # Setup ajax calls to use auth tokens
    BlueCarbon.bus.on('user:gotAuthToken', (token) ->
      console.log("logged in, using token #{token}")
      # Session persistence
      $.ajaxSetup(
        data:
          auth_token: token
        beforeSend: (xhr, settings) ->
          if (settings.type == 'POST')
            try
              settings.data = JSON.parse settings.data
              settings.data.auth_token = token
              settings.data = JSON.stringify settings.data
            catch err
              console.log "oh well"
      )
    )

    document.addEventListener "deviceready", @start, false

  start: =>
    window.BlueCarbon.SQLiteDb = window.sqlitePlugin.openDatabase("BlueCarbon.db", "1.0", "Test", 10000000)

    @map = new L.Map("map",
      center: new L.LatLng(24.2870, 54.3274)
      zoom: 10
      doubleClickZoom: false
    )
    @addBaseLayer()

    @map.addControl(new L.Control.Gps())

  addBaseLayer: ->
    window.requestFileSystem LocalFileSystem.PERSISTENT, 0, (fileSystem) =>
      window.fs = fileSystem

    tileLayerUrl = 'res/tiles/{z}/{x}/{y}.png'
    tileLayer = new L.TileLayer(tileLayerUrl, {
      maxZoom: 18
    }).addTo(@map)

    @trigger('mapReady')
