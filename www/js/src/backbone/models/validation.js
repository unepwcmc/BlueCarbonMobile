(function() {
  var _base,
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  window.BlueCarbon || (window.BlueCarbon = {});

  (_base = window.BlueCarbon).Models || (_base.Models = {});

  BlueCarbon.Models.Validation = (function(_super) {

    __extends(Validation, _super);

    function Validation() {
      Validation.__super__.constructor.apply(this, arguments);
    }

    Validation.prototype.schema = function() {
      return "geometry TEXT, type TEXT, area_id INTEGER, user_id INTEGER";
    };

    Validation.prototype.setGeomFromPoints = function(points) {
      var point;
      points = (function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = points.length; _i < _len; _i++) {
          point = points[_i];
          _results.push([point.lng, point.lat]);
        }
        return _results;
      })();
      points.push(points[0]);
      return this.set('geometry', [[points]]);
    };

    Validation.prototype.geomAsLatLngArray = function() {
      var latLngs, point, _i, _len, _ref;
      latLngs = [];
      _ref = this.get('geometry')[0][0];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        point = _ref[_i];
        latLngs.push(new L.LatLng(point[1], point[0]));
      }
      return latLngs;
    };

    Validation.prototype.parse = function(data) {
      if (data.geometry != null) data.geometry = JSON.parse(data.geometry);
      return Validation.__super__.parse.apply(this, arguments);
    };

    return Validation;

  })(Backbone.SyncableModel);

}).call(this);
