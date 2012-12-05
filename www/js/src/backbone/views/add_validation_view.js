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
      this.createAnalysis = __bind(this.createAnalysis, this);
      AddValidationView.__super__.constructor.apply(this, arguments);
    }

    AddValidationView.prototype.template = JST['area/add_polygon'];

    AddValidationView.prototype.events = {
      "touchstart #create-analysis": 'createAnalysis'
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

    AddValidationView.prototype.createAnalysis = function() {
      if (this.validation.get('geometry') == null) {
        alert("You've not finished your polygon!");
        return false;
      }
      this.validation.set($('form#validation-attributes').serializeObject());
      return this.validation.save();
    };

    AddValidationView.prototype.close = function() {
      this.polygonDraw.disable();
      return this.map.off('draw:poly-created');
    };

    return AddValidationView;

  })(Backbone.View);

}).call(this);
