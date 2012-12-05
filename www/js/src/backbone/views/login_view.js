(function() {
  var _base,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  window.BlueCarbon || (window.BlueCarbon = {});

  (_base = window.BlueCarbon).Views || (_base.Views = {});

  BlueCarbon.Views.LoginView = (function(_super) {

    __extends(LoginView, _super);

    function LoginView() {
      this.login = __bind(this.login, this);
      LoginView.__super__.constructor.apply(this, arguments);
    }

    LoginView.prototype.template = JST['area/login'];

    LoginView.prototype.className = 'login';

    LoginView.prototype.events = {
      "click #login": "login"
    };

    LoginView.prototype.initialize = function() {
      return this.user = new BlueCarbon.Models.User();
    };

    LoginView.prototype.login = function() {
      var _this = this;
      this.user.set($('#login-form').serializeObject());
      return this.user.login({
        success: function(data) {
          return _this.trigger('user:loggedIn', _this.user);
        },
        error: function(data) {
          return _this.showError('Unable to login');
        }
      });
    };

    LoginView.prototype.render = function() {
      this.$el.html(this.template());
      return this;
    };

    LoginView.prototype.showError = function(message) {
      $('.error').text(message);
      return $('.error').slideDown();
    };

    return LoginView;

  })(Backbone.View);

}).call(this);
