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
    waitForRemoteConsole = options.waitForRemoteConsole
    @localFileName = "bluecarbon.mbtiles"
    @remoteFile = "https://dl.dropbox.com/u/2324263/bluecarbon.mbtiles"
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
      )
    )

    #document.addEventListener "deviceready", @start, false)
    # This is for debugging in development, you can replace it with the above line for producion
    @ready=false
    if waitForRemoteConsole
      #alert('Waiting for weinre to connect, start app with:\n\n blueCarbonApp.start(); \n\n Disable this behavior by setting waitForRemoteConsole option to false')
      document.addEventListener "deviceready", (=> @ready = true), false
    else
      document.addEventListener "deviceready", (=>
        @ready = true
        @start()
      ), false

  start: =>
    unless @ready
      alert('not ready yet!')
      return false

    @map = new L.Map("map",
      center: new L.LatLng(24.2870, 54.3274)
      zoom: 10
    )
    @addBaseLayer()

  addBaseLayer: ->
    tileLayerUrl = 'res/tiles/{z}/{x}/{y}.png'
    tileLayer = new L.TileLayer(tileLayerUrl, {
      maxZoom: 18
    }).addTo(@map)

    @trigger('mapReady')

    window.BlueCarbon.SQLiteDb = window.sqlitePlugin.openDatabase("BlueCarbon.db", "1.0", "Test", 10000000)
