window.BlueCarbon ||= {}
window.BlueCarbon.Views ||= {}

class BlueCarbon.Views.LoginView extends Backbone.View
  template: JST['area/login']
  className: 'login'
  events:
    "click #login": "login"

  login: =>
    @model.login(
      $('#login-form').serializeObject(),
      success: (data)=>
        @model.trigger('user:loggedIn', @model)
      error: (data)=>
        @showError('Unable to login')
    )

  render: ->
    @$el.html(@template())
    return @

  showError: (message)->
    $('.error').text(message)
    $('.error').slideDown()
