// Generated by CoffeeScript 1.4.0
(function() {
  var _base;

  window.BlueCarbon || (window.BlueCarbon = {});

  (_base = window.BlueCarbon).Mixins || (_base.Mixins = {});

  BlueCarbon.Mixins.AreaMapLayers = {
    addMapLayers: function(area, map) {
      var db, layer, tileLayer, _i, _len, _ref, _results;
      this.removeTileLayers();
      this.tileLayers || (this.tileLayers = {});
      _ref = area.tileLayers();
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        layer = _ref[_i];
        db = window.sqlitePlugin.openDatabase(layer.mbtileLocation, "1.0", "Tiles", 2000000);
        tileLayer = new L.TileLayer.MBTiles(db, {
          tms: true
        }).addTo(map);
        _results.push(this.tileLayers["<span class='layer-legend " + layer.name + "'>" + layer.name + "</span>"] = tileLayer);
      }
      return _results;
    },
    addLayerControl: function(map) {
      if (this.tileLayers == null) {
        return;
      }
      this.removeLayerControl(map);
      this.layerControl = L.control.layers([], this.tileLayers);
      return this.layerControl.addTo(map);
    },
    removeTileLayers: function(map) {
      var layer, layerName, _ref, _results;
      console.log("removing tile layers");
      if (this.tileLayers != null) {
        _ref = this.tileLayers;
        _results = [];
        for (layerName in _ref) {
          layer = _ref[layerName];
          _results.push(map.removeLayer(layer));
        }
        return _results;
      }
    },
    removeLayerControl: function(map) {
      if (this.layerControl != null) {
        return map.removeControl(this.layerControl);
      }
    }
  };

}).call(this);
