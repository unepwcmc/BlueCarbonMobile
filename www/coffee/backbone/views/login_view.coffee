window.BlueCarbon ||= {}
window.BlueCarbon.Views ||= {}

class BlueCarbon.Views.LoginView extends Backbone.View
  template: JST['area/login']
  events:
    "click #login": "login"
  initialize: ->
    @user = new BlueCarbon.Models.User()

  login: =>
    @user.set($('#login-form').serializeObject())
    @user.login(
      success: (data)->
        console.log 'login success'
        $.ajax(
          type: 'POST'
          url: 'http://bluecarbon.unep-wcmc.org/areas.json'
          data: {area: {title: "Hi Decio 3"}}
          dataType: "text"
          beforeSend: (xhr) ->
            xhr.withCredentials = true
          success: ((data) ->
            console.log("success:")
            console.log(data)
          )
          error: ((data) ->
            console.log("error:")
            console.log(data)
          )
        )
        console.log data
      error: (data)->
        console.log 'login fail'
        console.log data
    )

  render: ->
    @$el.html(@template())
    return @
