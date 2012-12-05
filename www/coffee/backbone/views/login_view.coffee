window.BlueCarbon ||= {}
window.BlueCarbon.Views ||= {}

class BlueCarbon.Views.LoginView extends Backbone.View
  template: JST['area/login']
  className: 'login'
  events:
    "click #login": "login"
  initialize: ->
    @user = new BlueCarbon.Models.User()

  login: =>
    @user.set($('#login-form').serializeObject())
    @user.login(
      success: (data)=>
        @trigger('user:loggedIn', @user)
      error: (data)=>
        @showError('Unable to login')
    )

  render: ->
    @$el.html(@template())
    return @
  
  showError: (message)->
    $('.error').text(message)
    $('.error').slideDown()
