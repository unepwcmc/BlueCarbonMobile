(function() {
  var _base,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  window.BlueCarbon || (window.BlueCarbon = {});

  (_base = window.BlueCarbon).Collections || (_base.Collections = {});

  BlueCarbon.Collections.Areas = (function(_super) {

    __extends(Areas, _super);

    function Areas() {
      this.doSqliteSync = __bind(this.doSqliteSync, this);
      Areas.__super__.constructor.apply(this, arguments);
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
      return Areas.__super__.parse.apply(this, arguments);
    };

    return Areas;

  })(Backbone.SyncableCollection);

}).call(this);
