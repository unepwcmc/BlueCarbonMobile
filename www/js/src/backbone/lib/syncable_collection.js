(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  Backbone.SyncableCollection = (function(_super) {

    __extends(SyncableCollection, _super);

    function SyncableCollection() {
      this.doSqliteSync = __bind(this.doSqliteSync, this);
      SyncableCollection.__super__.constructor.apply(this, arguments);
    }

    SyncableCollection.prototype.localFetch = function(options) {
      var collection, success;
      options = (options ? _.clone(options) : {});
      if (options.parse === void 0) options.parse = true;
      collection = this;
      success = options.success;
      options.success = function(results, status, transaction) {
        var method;
        method = (options.update ? "update" : "reset");
        collection[method](collection.localParse(results, transaction), options);
        if (success) return success(collection, status, options);
      };
      return this.sqliteSync("read", this, options);
    };

    SyncableCollection.prototype.localSave = function(options) {
      return this.each(function(model) {
        return model.localSave({}, {
          error: function(a, b, c) {
            console.log("error saving model:");
            console.log(model);
            return console.log(arguments);
          }
        });
      });
    };

    SyncableCollection.prototype.sqliteSync = function(method, collection, options) {
      var _this = this;
      return Backbone.SyncableModel.prototype.createTableIfNotExist.call(collection.model.prototype, {
        success: function() {
          return _this.doSqliteSync(method, collection, options);
        },
        error: function(a, b, c) {
          console.log("Error confirming existence of DB for collection " + collection.model.constructor.name + ":");
          console.log(arguments);
          return options.error(error);
        }
      });
    };

    SyncableCollection.prototype.localParse = function(results, tx) {
      var i, jsonResults, modelAttributes;
      i = 0;
      jsonResults = [];
      while (results.rows.item(i)) {
        modelAttributes = results.rows.item(i);
        _.each(modelAttributes, function(value, key) {
          try {
            return modelAttributes[key] = JSON.parse(value);
          } catch (err) {

          }
        });
        jsonResults.push(modelAttributes);
        i = i + 1;
      }
      return jsonResults;
    };

    SyncableCollection.prototype.doSqliteSync = function(method, collection, options) {
      return alert("Collection " + collection.constructor.name + " must implement a doSqliteSync method which provides backbone.sync behavior, but to SQL");
    };

    return SyncableCollection;

  })(Backbone.Collection);

}).call(this);
