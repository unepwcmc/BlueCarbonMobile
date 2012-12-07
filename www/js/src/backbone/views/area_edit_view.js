(function() {
  var _base,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  window.BlueCarbon || (window.BlueCarbon = {});

  (_base = window.BlueCarbon).Views || (_base.Views = {});

  BlueCarbon.Views.AreaEditView = (function(_super) {

    __extends(AreaEditView, _super);

    function AreaEditView() {
      this.render = __bind(this.render, this);
      AreaEditView.__super__.constructor.apply(this, arguments);
    }

    AreaEditView.prototype.template = JST['area/edit'];

    AreaEditView.prototype.events = {
      "touchstart #new-validation": "fireAddValidation",
      "touchstart .ios-head .back": "fireBack"
    };

    AreaEditView.prototype.initialize = function(options) {
      this.area = options.area;
      this.validationList = new BlueCarbon.Collections.Validations({
        area: this.area
      });
      this.validationList.on('reset', this.render);
      return this.validationList.localFetch();
    };

    AreaEditView.prototype.fireAddValidation = function() {
      return this.trigger('addValidation', {
        area: this.area
      });
    };

    AreaEditView.prototype.fireBack = function() {
      return this.trigger('back');
    };

    AreaEditView.prototype.render = function() {
      var _this = this;
      this.$el.html(this.template({
        area: this.area
      }));
      this.validationList.each(function(validation) {
        return $('#validation-list').append(new BlueCarbon.Views.ValidationView({
          validation: validation
        }).render().el);
      });
      return this;
    };

    return AreaEditView;

  })(Backbone.View);

}).call(this);
