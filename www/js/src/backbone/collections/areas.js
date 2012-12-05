(function() {
  var _base,
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  window.BlueCarbon || (window.BlueCarbon = {});

  (_base = window.BlueCarbon).Collections || (_base.Collections = {});

  BlueCarbon.Collections.Areas = (function(_super) {

    __extends(Areas, _super);

    function Areas() {
      Areas.__super__.constructor.apply(this, arguments);
    }

    Areas.prototype.model = BlueCarbon.Models.Area;

    Areas.prototype.url = 'http://bluecarbon.unep-wcmc.org/areas.json';

    return Areas;

  })(Backbone.Collection);

}).call(this);
