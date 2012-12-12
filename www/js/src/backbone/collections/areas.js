// Generated by CoffeeScript 1.4.0
(function() {
  var _base,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.BlueCarbon || (window.BlueCarbon = {});

  (_base = window.BlueCarbon).Collections || (_base.Collections = {});

  BlueCarbon.Collections.Areas = (function(_super) {

    __extends(Areas, _super);

    function Areas() {
      this.doSqliteSync = __bind(this.doSqliteSync, this);
      return Areas.__super__.constructor.apply(this, arguments);
    }

    Areas.prototype.model = BlueCarbon.Models.Area;

    Areas.prototype.url = 'http://bluecarbon.unep-wcmc.org/areas.json';

    Areas.prototype.doSqliteSync = function(method, collection, options) {
      var sql,
        _this = this;
      sql = "";
      switch (method) {
        case "read":
          sql = "SELECT *\nFROM " + collection.model.prototype.constructor.name;
      }
      return BlueCarbon.SQLiteDb.transaction(function(tx) {
        return tx.executeSql(sql, [], function(tx, results) {
          return options.success.call(_this, results, 'success', tx);
        });
      }, function(tx, error) {
        return options.error.apply(_this, arguments);
      });
    };

    Areas.prototype.parse = function(data, response) {
      var areaModel, fetchedArea, fetchedLayer, localAreaModel, localLayer, _i, _j, _k, _l, _len, _len2, _len3, _len4, _ref, _ref2, _ref3;
      for (_i = 0, _len = data.length; _i < _len; _i++) {
        fetchedArea = data[_i];
        areaModel = null;
        _ref = this.models;
        for (_j = 0, _len2 = _ref.length; _j < _len2; _j++) {
          localAreaModel = _ref[_j];
          if (localAreaModel.get('id') === fetchedArea.id) {
            areaModel = localAreaModel;
            break;
          }
        }
        if (areaModel != null) {
          _ref2 = fetchedArea.mbtiles;
          for (_k = 0, _len3 = _ref2.length; _k < _len3; _k++) {
            fetchedLayer = _ref2[_k];
            _ref3 = areaModel.get('mbtiles');
            for (_l = 0, _len4 = _ref3.length; _l < _len4; _l++) {
              localLayer = _ref3[_l];
              if (localLayer.habitat === fetchedLayer.habitat) {
                console.log("adding date " + localLayer.downloadedAt + " to " + fetchedLayer);
                fetchedLayer.downloadedAt = localLayer.downloadedAt;
                break;
              }
            }
          }
        }
      }
      return Areas.__super__.parse.apply(this, arguments);
    };

    return Areas;

  })(Backbone.SyncableCollection);

}).call(this);
