(function() {
  var _base,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  window.BlueCarbon || (window.BlueCarbon = {});

  (_base = window.BlueCarbon).Views || (_base.Views = {});

  BlueCarbon.Views.AreaIndexView = (function(_super) {

    __extends(AreaIndexView, _super);

    function AreaIndexView() {
      this.render = __bind(this.render, this);
      AreaIndexView.__super__.constructor.apply(this, arguments);
    }

    AreaIndexView.prototype.template = JST['area/area_index'];

    AreaIndexView.prototype.className = 'area-index';

    AreaIndexView.prototype.initialize = function() {
      this.areaList = new BlueCarbon.Collections.Areas();
      this.areaList.on('reset', this.render);
      return this.areaList.fetch();
    };

    AreaIndexView.prototype.render = function() {
      this.$el.html(this.template({
        models: this.areaList.toJSON()
      }));
      return this;
    };

    return AreaIndexView;

  })(Backbone.View);

}).call(this);
