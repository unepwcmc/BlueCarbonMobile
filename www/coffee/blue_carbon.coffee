window.onerror = (message, url, linenumber) ->
  #alert "JavaScript error: #{message} on line #{linenumber} for #{url}"
  console.log "JavaScript error: #{message} on line #{linenumber} for #{url}"

window.Wcmc ||= {}
window.BlueCarbon ||= {}
window.BlueCarbon.Models ||= {}
window.BlueCarbon.Controllers ||= {}
window.BlueCarbon.Views ||= {}
window.BlueCarbon.Routers ||= {}

class BlueCarbon.App
  _.extend @::, Backbone.Events
  
  # Application Constructor
  constructor: ->
    @localFileName = "bluecarbon.mbtiles"
    @remoteFile = "https://dl.dropbox.com/u/2324263/bluecarbon.mbtiles"
    @bindEvents()
    @on('mapReady', =>
      @controller = new BlueCarbon.Controller(app:@)
    )
  
  # Bind Event Listeners
  #
  # Bind any events that are required on startup. Common events are:
  # 'load', 'deviceready', 'offline', and 'online'.
  bindEvents: ->
    document.addEventListener "deviceready", @onDeviceReady, false
  
  onDeviceReady: =>
    window.requestFileSystem LocalFileSystem.PERSISTENT, 0, (fileSystem) =>
      window.fs = fileSystem
      file = fs.root.getFile(@localFileName,
        create: false
      , @buildMap
      , @downloadBaseLayer)

  downloadBaseLayer: =>
    console.log "Downloading file..."
    ft = new FileTransfer()
    ft.download @remoteFile, fs.root.fullPath + "/" + @localFileName, @buildMap, (error) ->
      alert "Download failed, check error log"
      console.log error

  buildMap: =>
    db = window.sqlitePlugin.openDatabase(@localFileName, "1.0", "Tiles", 2000000)
    @map = new L.Map("map",
      center: new L.LatLng(24.2870, 54.3274)
      zoom: 10
    )
    tileLayer = new L.TileLayer.MBTiles(db,
      tms: true
    ).addTo(@map)

#var polygonDraw = new L.Polygon.Draw(map, {});
#polygonDraw.enable();

class BlueCarbon.Controller extends Wcmc.Controller
  constructor: (options)->
    @app = options.app
    sidePanel = new Backbone.ViewManager('#side-panel')
    validationView = new BlueCarbon.Views.AddValidationView(map: @app.map)
    sidePanel.showView(validationView)
