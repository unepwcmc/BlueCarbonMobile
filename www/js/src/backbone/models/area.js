(function() {
  var _base,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  window.BlueCarbon || (window.BlueCarbon = {});

  (_base = window.BlueCarbon).Models || (_base.Models = {});

  BlueCarbon.Models.Area = (function(_super) {

    __extends(Area, _super);

    function Area() {
      this.layerDownloaded = __bind(this.layerDownloaded, this);
      Area.__super__.constructor.apply(this, arguments);
    }

    Area.prototype.schema = function() {
      return "id INTEGER, title TEXT, coordinates TEXT, mbtiles TEXT, error TEXT, PRIMARY KEY (id)";
    };

    Area.prototype.downloadData = function() {
      var boundError, boundSuccess, ft, layer, _i, _len, _ref, _results,
        _this = this;
      _ref = this.get('mbtiles');
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        layer = _ref[_i];
        ft = new FileTransfer();
        boundSuccess = (function() {
          var _layer;
          _layer = layer;
          return function(fileEntry) {
            return _this.layerDownloaded(_layer, fileEntry);
          };
        })();
        boundError = (function() {
          var _layer;
          _layer = layer;
          return function(error) {
            alert("unable to download " + _layer.habitat);
            return console.log(error);
          };
        })();
        _results.push(ft.download(layer.url, this.filenameForLayer(layer), boundSuccess, boundError));
      }
      return _results;
    };

    Area.prototype.filenameForLayer = function(layer) {
      return fs.root.fullPath + "/" + layer.habitat;
    };

    Area.prototype.layerDownloaded = function(layer, fileEntry) {
      var index, mbTiles, storedLayer, _len;
      console.log("downloaded " + layer.habitat);
      layer.downloadedAt = (new Date()).getTime();
      mbTiles = this.get('mbtiles');
      for (index = 0, _len = mbTiles.length; index < _len; index++) {
        storedLayer = mbTiles[index];
        if (storedLayer.habitat === layer.habitat) mbTiles[index] = layer;
      }
      this.set('mbtiles', mbTiles);
      return this.localSave();
    };

    Area.prototype.downloadState = function() {
      var layer, _i, _len, _ref;
      _ref = this.get('mbtiles');
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        layer = _ref[_i];
        if (layer.status === 'pending' || layer.status === 'generating') {
          return 'data generating';
        }
        if (!(layer.downloadedAt != null)) return 'no data';
        console.log("comparing downloadedAt(" + layer.downloadedAt + ") < last_generated_at(" + (Date.parse(layer.last_generated_at)) + ")");
        if (layer.downloadedAt < Date.parse(layer.last_generated_at)) {
          return 'out of date';
        }
      }
      return "ready";
    };

    Area.prototype.lastDownloaded = function() {
      var layer, lowestDownloaded, _i, _len, _ref;
      lowestDownloaded = "";
      _ref = this.get('mbtiles');
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        layer = _ref[_i];
        if (layer.downloadedAt != null) {
          if (!_.isNumber(lowestDownloaded) || layer.downloadedAt < lowestDownloaded) {
            lowestDownloaded = layer.downloadedAt;
          }
        }
      }
      return lowestDownloaded;
    };

    return Area;

  })(Backbone.SyncableModel);

}).call(this);
