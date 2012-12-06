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

    SyncableCollection.prototype.fetch = function(options) {
      this.sync = this.sqliteSync;
      return SyncableCollection.__super__.fetch.apply(this, arguments);
    };

    SyncableCollection.prototype.sqliteSync = function(method, collection, options) {
      var _this = this;
      return Backbone.SyncableModel.prototype.createTableIfNotExist.call(collection.model.prototype, {
        success: function() {
          return _this.doSqliteSync(method, collection, options);
        },
        error: function(a, b, c) {
          console.log('Error fetching collection:');
          console.log(arguments);
          return options.error(error);
        }
      });
    };

    SyncableCollection.prototype.parse = function(results, tx) {
      var i, jsonResults;
      i = 0;
      jsonResults = [];
      while (results.rows.item(i)) {
        jsonResults.push(results.rows.item(i));
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
