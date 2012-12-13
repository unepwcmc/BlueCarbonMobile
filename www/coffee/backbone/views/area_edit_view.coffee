window.BlueCarbon ||= {}
window.BlueCarbon.Views ||= {}

class BlueCarbon.Views.AreaEditView extends Backbone.View
  template: JST['area/edit']
  events :
    "touchstart #new-validation" : "fireAddValidation"
    "touchstart .ios-head .back" : "fireBack"

  initialize: (options) ->
    @area = options.area
    @map = options.map
    @validationList = new BlueCarbon.Collections.Validations([], area: @area)
    @validationList.on('reset', @render)
    @validationList.localFetch()

    @subViews = []
  
  fireAddValidation: ->
    @trigger('addValidation', area: @area)

  fireBack: ->
    @trigger('back')

  render: =>
    @$el.html(@template(area: @area))
    @validationList.each (validation)=>
      validationView =  new BlueCarbon.Views.ValidationView(validation:validation)
      $('#validation-list').append(validationView.render().el)
      @subViews.push validationView
    @addMapLayers()
    return @

  addMapLayers: ->
    @removeTileLayers()
    @tileLayers ||= []
    for layer in @area.tileLayers()
      console.log "adding tile layer for #{layer.mbtileLocation}"
      db = window.sqlitePlugin.openDatabase(layer.mbtileLocation, "1.0", "Tiles", 2000000)
      tileLayer = new L.TileLayer.MBTiles(db,
        tms: true
      ).addTo(@map)
      @tileLayers.push tileLayer

  removeTileLayers: ->
    return unless @tileLayers?
    for layer in @tileLayers
      @map.remove(layer)

  onClose: ->
    for view in @subViews
      view.close()
    @removeTileLayers()
