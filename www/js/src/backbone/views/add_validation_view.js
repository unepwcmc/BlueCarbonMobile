(function() {
  var _base,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  window.BlueCarbon || (window.BlueCarbon = {});

  (_base = window.BlueCarbon).Views || (_base.Views = {});

  BlueCarbon.Views.AddValidationView = (function(_super) {

    __extends(AddValidationView, _super);

    function AddValidationView() {
      this.createPolygon = __bind(this.createPolygon, this);
      AddValidationView.__super__.constructor.apply(this, arguments);
    }

    AddValidationView.prototype.template = JST['area/add_polygon'];

    AddValidationView.prototype.events = {
      "touchstart #create-polygon": 'createPolygon'
    };

    AddValidationView.prototype.initialize = function(options) {
      var _this = this;
      this.map = options.map;
      this.validation = new BlueCarbon.Models.Validation();
      return this.map.on('draw:poly-created', function(e) {
        return _this.validation.setGeomFromPoints(e.poly.getLatLngs());
      });
    };

    AddValidationView.prototype.render = function() {
      this.polygonDraw = new L.Polygon.Draw(this.map, {});
      this.polygonDraw.enable();
      this.$el.html(this.template());
      return this;
    };

    AddValidationView.prototype.createPolygon = function() {
      if (this.validation.get('geometry') == null) {
        alert("You've not finished your polygon!");
        return false;
      }
      return alert("Implement persistence plx");
    };

    AddValidationView.prototype.close = function() {
      this.polygonDraw.disable();
      return this.map.off('draw:poly-created');
    };

    return AddValidationView;

  })(Backbone.View);

}).call(this);
