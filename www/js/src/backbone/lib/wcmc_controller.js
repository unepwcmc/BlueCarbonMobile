(function() {

  window.Wcmc || (window.Wcmc = {});

  Wcmc.Controller = (function() {

    function Controller() {}

    _.extend(Controller.prototype, Backbone.Events);

    Controller.prototype.transitionToActionOn = function(publisher, event, action) {
      var boundAction,
        _this = this;
      this.actionEventBindings || (this.actionEventBindings = []);
      boundAction = function() {
        return _this.transitionToAction(action, arguments);
      };
      publisher.on(event, boundAction);
      return this.actionEventBindings.push({
        publisher: publisher,
        event: event,
        action: boundAction
      });
    };

    Controller.prototype.clearActionEventBindings = function() {
      _.each(this.actionEventBindings, function(binding) {
        return binding.publisher.off(binding.event, binding.action);
      });
      return this.actionEventBindings = [];
    };

    Controller.prototype.transitionToAction = function(action, eventArguments) {
      this.clearActionEventBindings();
      return action.apply(this, eventArguments);
    };

    return Controller;

  })();

}).call(this);
