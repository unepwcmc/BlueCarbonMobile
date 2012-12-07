(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  Backbone.SyncableModel = (function(_super) {

    __extends(SyncableModel, _super);

    function SyncableModel() {
      this.createTableIfNotExist = __bind(this.createTableIfNotExist, this);
      SyncableModel.__super__.constructor.apply(this, arguments);
    }

    SyncableModel.prototype.localSave = function(attributes, options) {
      this.sync = this.sqliteSync;
      this.save.apply(this, arguments);
      return this.sync = Backbone.sync;
    };

    SyncableModel.prototype.localFetch = function(options) {
      this.sync = this.sqliteSync;
      this.fetch.apply(this, arguments);
      return this.sync = Backbone.sync;
    };

    SyncableModel.prototype.sqliteSync = function(method, model, options) {
      var _this = this;
      return this.createTableIfNotExist({
        success: function() {
          return _this.doSqliteSync(method, model, options);
        },
        error: function(error) {
          return options.error(error);
        }
      });
    };

    SyncableModel.prototype.doSqliteSync = function(method, model, options) {
      var attr, attrs, fields, sql, val, values,
        _this = this;
      attrs = model.toJSON();
      sql = "";
      switch (method) {
        case "create":
          fields = [];
          values = [];
          for (attr in attrs) {
            val = attrs[attr];
            if (_.isArray(val) || _.isObject(val)) val = JSON.stringify(val);
            fields.push(attr);
            values.push("\"" + val + "\"");
          }
          sql = "INSERT INTO " + model.constructor.name + "\n( " + (fields.join(", ")) + " )\nVALUES ( " + (values.join(", ")) + " );";
          break;
        case "update":
          sql = [];
          for (attr in attrs) {
            val = attrs[attr];
            sql.push("UPDATE " + model.constructor.name + "\nSET " + attr + "=\"" + val + "\"\nWHERE id=\"" + attrs['id'] + "\"");
          }
          sql = sql.join("; ");
          break;
        case "read":
          sql = "SELECT " + (Object.keys(attrs)) + "\nFROM " + model.constructor.name + "\nWHERE id=\"" + attrs['id'] + "\";";
          break;
        case "delete":
          sql = "DELETE FROM " + model.constructor.name + "\nWHERE id=\"" + attrs['id'] + "\";";
      }
      console.log(sql);
      return BlueCarbon.SQLiteDb.transaction(function(tx) {
        return tx.executeSql(sql, [], function(tx, results) {
          return options.success.apply(_this, arguments);
        });
      }, function(tx, error) {
        return options.error.apply(_this, arguments);
      });
    };

    SyncableModel.prototype.createTableIfNotExist = function(options) {
      var sql,
        _this = this;
      if (this.schema == null) {
        alert("Model " + this.constructor.name + " must implement a this.schema() method, containing a SQLite comma separated string of 'name TYPE, name2 TYPE2...' so the DB can be init");
        return options.error();
      }
      sql = "CREATE TABLE IF NOT EXISTS " + this.constructor.name + " (" + (this.schema()) + ")";
      return BlueCarbon.SQLiteDb.transaction(function(tx) {
        return tx.executeSql(sql, [], function(tx, results) {
          return options.success.apply(_this, arguments);
        });
      }, function(tx, error) {
        console.log("failed to make check exists");
        return options.error.apply(_this, arguments);
      });
    };

    return SyncableModel;

  })(Backbone.Model);

}).call(this);
