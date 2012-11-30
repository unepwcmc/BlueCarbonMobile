# Extended controller that adds concept of action events bindings,
# which are event bindings that are only valid for the duration
# of an action
window.Wcmc ||= {}
class Wcmc.Controller
  _.extend @::, Backbone.Events
  # Add binding which is only valid for action duration.
  transitionToActionOn: (event, action) ->
    @actionEventBindings ||= []
    @actionEventBindings.push(event: event, action: action)
    Pica.vent.on(event, () =>
      @transitionToAction(action, arguments)
    )

  clearActionEventBindings: () ->
    _.each @actionEventBindings, (binding) ->
      Pica.vent.off(binding.event, binding.action)

  transitionToAction: (action, eventArguments) ->
    @clearActionEventBindings()
    action.apply(@, eventArguments)

