(function() {
  var _base,
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  window.BlueCarbon || (window.BlueCarbon = {});

  (_base = window.BlueCarbon).Views || (_base.Views = {});

  BlueCarbon.Views.AreaEditView = (function(_super) {

    __extends(AreaEditView, _super);

    function AreaEditView() {
      AreaEditView.__super__.constructor.apply(this, arguments);
    }

    AreaEditView.prototype.template = JST['area/edit'];

    AreaEditView.prototype.events = {
      "touchstart #new-validation": "fireAddValidation"
    };

    AreaEditView.prototype.initialize = function(options) {
      return this.area = options.area;
    };

    AreaEditView.prototype.fireAddValidation = function() {
      return this.trigger('addValidation', {
        area: this.area
      });
    };

    AreaEditView.prototype.render = function() {
      this.$el.html(this.template({
        area: this.area
      }));
      return this;
    };

    return AreaEditView;

  })(Backbone.View);

}).call(this);
