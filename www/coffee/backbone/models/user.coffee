window.BlueCarbon ||= {}
window.BlueCarbon.Models ||= {}

class BlueCarbon.Models.User extends Backbone.SyncableModel
  schema: ->
    "id INTEGER, user_id INTEGER, auth_token TEXT"

  # Takes success and error callback options, tries 
  # to login with model attributes
  login: (form, options) ->
    # Test for existing login
    $.ajax(
      type: 'GET'
      url: 'http://bluecarbon.unep-wcmc.org/admins/me.json'
      success: options.success
      error: (data)=>
        if data.error?
          # Not logged in, login
          $.ajax(
            type: 'POST'
            url: 'http://bluecarbon.unep-wcmc.org/my/admins/sign_in.json'
            data:
              admin:
                email: form.email
                password: form.password
            dataType: "json"
            success: (data) =>
              @set('id', '1')
              @set('user_id', data.id)
              @set('auth_token', data.auth_token)
              @localSave()

              BlueCarbon.bus.trigger('user:gotAuthToken', data.auth_token)
              options.success(@)
            error: options.error
          )
        else
          options.error(data)
    )
