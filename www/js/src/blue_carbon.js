(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  window.onerror = function(message, url, linenumber) {
    alert("JavaScript error: " + message + " on line " + linenumber + " for " + url);
    return console.log("JavaScript error: " + message + " on line " + linenumber + " for " + url);
  };

  window.BlueCarbon = {};

  window.BlueCarbon.Models = {};

  window.BlueCarbon.Controllers = {};

  window.BlueCarbon.Views = {};

  window.BlueCarbon.Routers = {};

  BlueCarbon.App = (function() {

    function App() {
      this.buildMap = __bind(this.buildMap, this);
      this.downloadBaseLayer = __bind(this.downloadBaseLayer, this);
      this.onDeviceReady = __bind(this.onDeviceReady, this);      this.localFileName = "vector.mbtiles";
      this.remoteFile = "https://dl.dropbox.com/u/2324263/vector.mbtiles";
      this.bindEvents();
    }

    App.prototype.bindEvents = function() {
      console.log('binding');
      return document.addEventListener("deviceready", this.onDeviceReady, false);
    };

    App.prototype.onDeviceReady = function() {
      var _this = this;
      console.log('ready');
      return window.requestFileSystem(LocalFileSystem.PERSISTENT, 0, function(fileSystem) {
        var file, fs;
        fs = fileSystem;
        return file = fs.root.getFile(_this.localFileName, {
          create: false
        }, _this.buildMap, _this.downloadBaseLayer);
      });
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
      var db, tileLayer;
      db = window.sqlitePlugin.openDatabase(this.localFileName, "1.0", "Tiles", 2000000);
      this.map = new L.Map("map", {
        center: new L.LatLng(24.2870, 54.3274),
        zoom: 10
      });
      return tileLayer = new L.TileLayer.MBTiles(db, {
        tms: true
      }).addTo(this.map);
    };

    return App;

  })();

}).call(this);
