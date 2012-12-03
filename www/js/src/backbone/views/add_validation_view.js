(function() {
  var _base,
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  window.BlueCarbon || (window.BlueCarbon = {});

  (_base = window.BlueCarbon).Views || (_base.Views = {});

  BlueCarbon.Views.AddValidationView = (function(_super) {

    __extends(AddValidationView, _super);

    function AddValidationView() {
      AddValidationView.__super__.constructor.apply(this, arguments);
    }

    AddValidationView.prototype.template = JST['area/add_polygon'];

    AddValidationView.prototype.initialize = function(options) {
      var _this = this;
      this.map = options.map;
      this.polygonDrawn = false;
      return this.map.on('draw:poly-created', function(e) {
        var mapPolygon;
        mapPolygon = e.poly;
        return _this.polygonDrawn = false;
      });
    };

    AddValidationView.prototype.render = function() {
      this.polygonDraw = new L.Polygon.Draw(this.map, {});
      this.polygonDraw.enable();
      this.$el.html(this.template());
      return this;
    };

    AddValidationView.prototype.createPolygon = function(mapPolygon) {
      var _this = this;
      this.polygon.setGeomFromPoints(mapPolygon.getLatLngs());
      return this.polygon.save({
        success: function() {
          _this.close();
          if (typeof finishedCallback !== "undefined" && finishedCallback !== null) {
            return _this.finishedCallback();
          }
        }
      });
    };

    AddValidationView.prototype.close = function() {
      this.polygonDraw.disable();
      return Pica.config.map.off('draw:poly-created');
    };

    return AddValidationView;

  })(Backbone.View);

}).call(this);
