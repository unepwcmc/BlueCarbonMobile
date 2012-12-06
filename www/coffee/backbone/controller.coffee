class BlueCarbon.Controller extends Wcmc.Controller
  constructor: (options)->
    @app = options.app
    @sidePanel = new Backbone.ViewManager('#side-panel')
    @modal = new Backbone.ViewManager('#modal-container')

    @loginUser()

  loginUser: =>
    loginView = new BlueCarbon.Views.LoginView()
    $('#modal-disabler').addClass('active')
    @modal.showView(loginView)

    @transitionToActionOn(loginView, 'user:loggedIn', =>
      $('#modal-disabler').removeClass('active')
      @areaIndex()
    )

  areaIndex: =>
    areaIndexView = new BlueCarbon.Views.AreaIndexView()
    @sidePanel.showView(areaIndexView)

    @transitionToActionOn(BlueCarbon.bus, 'area:startTrip', @areaEdit)

  areaEdit: (options) =>
    areaEditView = new BlueCarbon.Views.AreaEditView(area: options.area)
    @sidePanel.showView(areaEditView)

    @transitionToActionOn(areaEditView, 'addValidation', @addValidation)
    @transitionToActionOn(areaEditView, 'back', @areaIndex)

  addValidation: (options) =>
    addValidationView = new BlueCarbon.Views.AddValidationView(area: options.area, map: @app.map)
    @sidePanel.showView(addValidationView)

    @transitionToActionOn(addValidationView, 'validation:created', @areaEdit)
    @transitionToActionOn(addValidationView, 'back', @areaEdit)
