(function() {
  var _base, _base2, _base3, _base4,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  window.onerror = function(message, url, linenumber) {
    return console.log("JavaScript error: " + message + " on line " + linenumber + " for " + url);
  };

  window.Wcmc || (window.Wcmc = {});

  window.BlueCarbon || (window.BlueCarbon = {});

  (_base = window.BlueCarbon).Models || (_base.Models = {});

  (_base2 = window.BlueCarbon).Controllers || (_base2.Controllers = {});

  (_base3 = window.BlueCarbon).Views || (_base3.Views = {});

  (_base4 = window.BlueCarbon).Routers || (_base4.Routers = {});

  BlueCarbon.App = (function() {

    _.extend(App.prototype, Backbone.Events);

    function App() {
      this.buildMap = __bind(this.buildMap, this);
      this.downloadBaseLayer = __bind(this.downloadBaseLayer, this);
      this.onDeviceReady = __bind(this.onDeviceReady, this);
      var _this = this;
      this.localFileName = "bluecarbon.mbtiles";
      this.remoteFile = "https://dl.dropbox.com/u/2324263/bluecarbon.mbtiles";
      this.on('mapReady', function() {
        return _this.controller = new BlueCarbon.Controller({
          app: _this
        });
      });
      this.bindEvents();
    }

    App.prototype.bindEvents = function() {
      return document.addEventListener("deviceready", this.onDeviceReady, false);
    };

    App.prototype.onDeviceReady = function() {
      var _this = this;
      return window.requestFileSystem(LocalFileSystem.PERSISTENT, 0, function(fileSystem) {
        var file;
        window.fs = fileSystem;
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
      tileLayer = new L.TileLayer.MBTiles(db, {
        tms: true
      }).addTo(this.map);
      return this.trigger('mapReady');
    };

    return App;

  })();

  BlueCarbon.Controller = (function(_super) {

    __extends(Controller, _super);

    function Controller(options) {
      var validationView;
      this.app = options.app;
      this.sidePanel = new Backbone.ViewManager('#side-panel');
      validationView = new BlueCarbon.Views.AddValidationView({
        map: this.app.map
      });
      this.sidePanel.showView(validationView);
    }

    return Controller;

  })(Wcmc.Controller);

}).call(this);
