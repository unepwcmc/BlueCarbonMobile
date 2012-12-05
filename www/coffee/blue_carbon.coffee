window.onerror = (message, url, linenumber) ->
  console.log "JavaScript error: #{message} on line #{linenumber} for #{url}"
  alert "JavaScript error: #{message} on line #{linenumber} for #{url}"

$.support.cors = true

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
    window.requestFileSystem LocalFileSystem.PERSISTENT, 0, (fileSystem) =>
      window.fs = fileSystem
      file = fs.root.getFile(@localFileName,
        create: false
      , @buildMap
      , @downloadBaseLayer)

    window.BlueCarbon.SQLiteDb = window.sqlitePlugin.openDatabase("BlueCarbon.db", "1.0", "Test", 10000000)

  downloadBaseLayer: =>
    console.log "Downloading file..."
    ft = new FileTransfer()
    ft.download @remoteFile, fs.root.fullPath + "/" + @localFileName, @buildMap, (error) ->
      alert "Download failed, check error log"
      console.log error

  buildMap: =>
    db = window.sqlitePlugin.openDatabase(@localFileName, "1.0", "Tiles", 2000000)
    tileLayer = new L.TileLayer.MBTiles(db,
      tms: true
    ).addTo(@map)

    @trigger('mapReady')

#var polygonDraw = new L.Polygon.Draw(map, {});
#polygonDraw.enable();

class BlueCarbon.Controller extends Wcmc.Controller
  constructor: (options)->
    @app = options.app
    @sidePanel = new Backbone.ViewManager('#side-panel')
    @modal = new Backbone.ViewManager('#modal-container')

    @loginUser()

  loginUser: =>
    loginView = new BlueCarbon.Views.LoginView()
    $('#modal-disabler').addClass('active')
    @modal.showView(loginView)

    @transitionToActionOn(loginView, 'user:loggedIn', @areaEdit)

  areaEdit: =>
    areaEditView = new BlueCarbon.Views.AreaEditView()
    @sidePanel.showView(areaEditView)

    @transitionToActionOn(areaEditView, 'addPolygon', @addValidation)

  addValidation: (options) =>
    validationView = new BlueCarbon.Views.AddValidationView(map: @app.map)
    @sidePanel.showView(validationView)

    @transitionToActionOn(validationView, 'polygon:created', @areaEdit)
