(function() {
  var __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  Backbone.ViewManager = (function() {

    function ViewManager(element) {
      this.element = element;
    }

    ViewManager.prototype.showView = function(view) {
      if (this.currentView) this.currentView.close();
      this.currentView = view;
      this.currentView.render();
      return $(this.element).html(this.currentView.el);
    };

    ViewManager.prototype.isEmpty = function() {
      return $(this.element).is(':empty');
    };

    return ViewManager;

  })();

  Backbone.View = (function(_super) {

    __extends(View, _super);

    function View() {
      View.__super__.constructor.apply(this, arguments);
    }

    View.prototype.bind = function(model, ev, callback) {
      View.__super__.bind.apply(this, arguments);
      if (this.bindings == null) this.bindings = [];
      return this.bindings.push({
        model: model,
        ev: ev,
        callback: callback
      });
    };

    View.prototype.unbindFromAll = function() {
      _.each(this.bindings, function(binding) {
        return binding.model.unbind(binding.ev, binding.callback);
      });
      return this.bindings = [];
    };

    View.prototype.close = function() {
      this.unbindFromAll();
      this.unbind();
      this.remove();
      if (this.onClose) return this.onClose();
    };

    return View;

  })(Backbone.View);

}).call(this);
