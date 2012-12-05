(function() {
  var _base,
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  window.BlueCarbon || (window.BlueCarbon = {});

  (_base = window.BlueCarbon).Models || (_base.Models = {});

  BlueCarbon.Models.User = (function(_super) {

    __extends(User, _super);

    function User() {
      User.__super__.constructor.apply(this, arguments);
    }

    User.prototype.login = function(options) {
      var _this = this;
      return $.ajax({
        type: 'GET',
        url: 'http://bluecarbon.unep-wcmc.org/admins/me.json',
        success: options.success,
        error: function(data) {
          if (data.error != null) {
            return $.ajax({
              type: 'POST',
              url: 'http://bluecarbon.unep-wcmc.org/my/admins/sign_in.json',
              data: {
                admin: _this.attributes
              },
              dataType: "json",
              success: function(data) {
                _this.set('auth_token', data.auth_token);
                BlueCarbon.bus.trigger('user:gotAuthToken', data.auth_token);
                return options.success(_this);
              },
              error: options.error
            });
          } else {
            return options.error(data);
          }
        }
      });
    };

    return User;

  })(Backbone.Model);

}).call(this);
