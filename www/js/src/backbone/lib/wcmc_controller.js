(function() {

  window.Wcmc || (window.Wcmc = {});

  Wcmc.Controller = (function() {

    function Controller() {}

    _.extend(Controller.prototype, Backbone.Events);

    Controller.prototype.transitionToActionOn = function(event, action) {
      var _this = this;
      this.actionEventBindings || (this.actionEventBindings = []);
      this.actionEventBindings.push({
        event: event,
        action: action
      });
      return Pica.vent.on(event, function() {
        return _this.transitionToAction(action, arguments);
      });
    };

    Controller.prototype.clearActionEventBindings = function() {
      return _.each(this.actionEventBindings, function(binding) {
        return Pica.vent.off(binding.event, binding.action);
      });
    };

    Controller.prototype.transitionToAction = function(action, eventArguments) {
      this.clearActionEventBindings();
      return action.apply(this, eventArguments);
    };

    return Controller;

  })();

}).call(this);
