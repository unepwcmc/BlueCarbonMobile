(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  BlueCarbon.Controller = (function(_super) {

    __extends(Controller, _super);

    function Controller(options) {
      this.addValidation = __bind(this.addValidation, this);
      this.areaEdit = __bind(this.areaEdit, this);
      this.areaIndex = __bind(this.areaIndex, this);
      this.loginUser = __bind(this.loginUser, this);      this.app = options.app;
      this.sidePanel = new Backbone.ViewManager('#side-panel');
      this.modal = new Backbone.ViewManager('#modal-container');
      this.loginUser();
    }

    Controller.prototype.loginUser = function() {
      var loginView,
        _this = this;
      loginView = new BlueCarbon.Views.LoginView();
      $('#modal-disabler').addClass('active');
      this.modal.showView(loginView);
      return this.transitionToActionOn(loginView, 'user:loggedIn', function() {
        $('#modal-disabler').removeClass('active');
        return _this.areaIndex();
      });
    };

    Controller.prototype.areaIndex = function() {
      var areaIndexView;
      areaIndexView = new BlueCarbon.Views.AreaIndexView();
      this.sidePanel.showView(areaIndexView);
      return this.transitionToActionOn(BlueCarbon.bus, 'area:startTrip', this.areaEdit);
    };

    Controller.prototype.areaEdit = function(options) {
      var areaEditView;
      areaEditView = new BlueCarbon.Views.AreaEditView({
        area: options.area
      });
      this.sidePanel.showView(areaEditView);
      this.transitionToActionOn(areaEditView, 'addValidation', this.addValidation);
      return this.transitionToActionOn(areaEditView, 'back', this.areaIndex);
    };

    Controller.prototype.addValidation = function(options) {
      var addValidationView;
      addValidationView = new BlueCarbon.Views.AddValidationView({
        area: options.area,
        map: this.app.map
      });
      this.sidePanel.showView(addValidationView);
      this.transitionToActionOn(addValidationView, 'validation:created', this.areaEdit);
      return this.transitionToActionOn(addValidationView, 'back', this.areaEdit);
    };

    return Controller;

  })(Wcmc.Controller);

}).call(this);
