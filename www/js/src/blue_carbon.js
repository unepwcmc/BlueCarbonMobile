(function() {
  var _base, _base2, _base3, _base4,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  window.onerror = function(message, url, linenumber) {
    console.log("JavaScript error: " + message + " on line " + linenumber + " for " + url);
    return alert("JavaScript error: " + message + " on line " + linenumber + " for " + url);
  };

  $.support.cors = true;

  $.ajaxSetup({
    data: {
      auth_token: ''
    }
  });

  window.Wcmc || (window.Wcmc = {});

  window.BlueCarbon || (window.BlueCarbon = {});

  window.BlueCarbon.bus = _.extend({}, Backbone.Events);

  (_base = window.BlueCarbon).Models || (_base.Models = {});

  (_base2 = window.BlueCarbon).Controllers || (_base2.Controllers = {});

  (_base3 = window.BlueCarbon).Views || (_base3.Views = {});

  (_base4 = window.BlueCarbon).Routers || (_base4.Routers = {});

  BlueCarbon.App = (function() {

    _.extend(App.prototype, Backbone.Events);

    function App(options) {
      this.buildMap = __bind(this.buildMap, this);
      this.downloadBaseLayer = __bind(this.downloadBaseLayer, this);
      this.start = __bind(this.start, this);
      var waitForRemoteConsole,
        _this = this;
      waitForRemoteConsole = options.waitForRemoteConsole;
      this.localFileName = "bluecarbon.mbtiles";
      this.remoteFile = "https://dl.dropbox.com/u/2324263/bluecarbon.mbtiles";
      this.on('mapReady', function() {
        return _this.controller = new BlueCarbon.Controller({
          app: _this
        });
      });
      BlueCarbon.bus.on('user:gotAuthToken', function(token) {
        console.log("logged in, using token " + token);
        return $.ajaxSetup({
          data: {
            auth_token: token
          }
        });
      });
      this.ready = false;
      if (waitForRemoteConsole) {
        document.addEventListener("deviceready", (function() {
          return _this.ready = true;
        }), false);
      } else {
        document.addEventListener("deviceready", (function() {
          _this.ready = true;
          return _this.start();
        }), false);
      }
    }

    App.prototype.start = function() {
      if (!this.ready) {
        alert('not ready yet!');
        return false;
      }
      this.map = new L.Map("map", {
        center: new L.LatLng(24.2870, 54.3274),
        zoom: 10
      });
      return this.addBaseLayer();
    };

    App.prototype.addBaseLayer = function() {
      var _this = this;
      window.requestFileSystem(LocalFileSystem.PERSISTENT, 0, function(fileSystem) {
        var file;
        window.fs = fileSystem;
        return file = fs.root.getFile(_this.localFileName, {
          create: false
        }, _this.buildMap, _this.downloadBaseLayer);
      });
      return window.BlueCarbon.SQLiteDb = window.sqlitePlugin.openDatabase("BlueCarbon.db", "1.0", "Test", 10000000);
    };

    App.prototype.downloadBaseLayer = function() {
      var ft;
      console.log("Downloading file...");
      ft = new FileTransfer();
      return ft.download(this.remoteFile, fs.root.fullPath + "/" + this.localFileName, this.buildMap, function(error) {
        alert("Download failed, check error log");
        return console.log(error);
      });
    };

    App.prototype.buildMap = function() {
      var tileLayer, tileLayerUrl;
      tileLayerUrl = 'res/tiles/{z}/{x}/{y}.png';
      tileLayer = new L.TileLayer(tileLayerUrl, {
        maxZoom: 18
      }).addTo(this.map);
      return this.trigger('mapReady');
    };

    return App;

  })();

}).call(this);
