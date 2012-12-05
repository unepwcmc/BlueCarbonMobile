(function() {
  var _base,
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  window.BlueCarbon || (window.BlueCarbon = {});

  (_base = window.BlueCarbon).Models || (_base.Models = {});

  BlueCarbon.Models.Area = (function(_super) {

    __extends(Area, _super);

    function Area() {
      Area.__super__.constructor.apply(this, arguments);
    }

    return Area;

  })(Backbone.Model);

}).call(this);
