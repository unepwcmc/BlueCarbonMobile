window.BlueCarbon ||= {}
window.BlueCarbon.Views ||= {}

class BlueCarbon.Views.AddValidationView extends Backbone.View
  template: JST['area/add_polygon']
  events:
    "touchend #create-analysis": 'createAnalysis'
    "touchend .ios-head .back" : "fireBack"
    "touchend #undo-last-marker" : "removeLastMarker"
    "change [name=habitat]" : "showAttributesForHabitat"
    "change [name=action]" : "showAttributesForAction"

  initialize: (options)->
    @area = options.area
    @map = options.map

    @validation = new BlueCarbon.Models.Validation()

    @map.on 'draw:polygon:add-vertex', @updatePolygonDrawHelpText

    @map.on 'draw:poly-created', (e) =>
      @validation.setGeomFromPoints(e.poly.getLatLngs())
      @mapPolygon = new L.Polygon(e.poly.getLatLngs())
      @mapPolygon.addTo(@map)
      @showForm()

  render: () ->
    # Turn on Leaflet.draw polygon tool
    @polygonDraw = new L.Polygon.Draw(@map, {})
    @polygonDraw.enable()

    @$el.html(@template(area: @area))
    @addMapLayers(@area, @map)
    @addLayerControl(@map)
    return @

  undoBtnHtml: "<br/><a id='undo-last-marker' class='btn'><img src='css/images/undo_selected.png'/>Undo last point</a>"

  updatePolygonDrawHelpText: =>
    markerCount = @polygonDraw._markers.length
    if markerCount > 2
      text = 'Tap the first point to close this shape.'
      text += @undoBtnHtml
    else if markerCount > 0
      text = 'Tap another point to continue drawing shape.'
      text += @undoBtnHtml
    else
      text = 'Draw your polygon by tapping on the map'

    $('#draw-polygon-notice').html(text)

  removeLastMarker: =>
    @polygonDraw.removeLastMarker()
    @updatePolygonDrawHelpText()

  createAnalysis: () =>
    @clearUnselectedFields()
    @validation.set($('form#validation-attributes').serializeObject())
    @validation.localSave(@validation.attributes,
      success: =>
        console.log 'successfully saved:'
        console.log @validation
        @trigger('validation:created', area: @area)
      error: (a,b,c)=>
        console.log 'error saving validation:'
        console.log arguments
    )

  fireBack: ->
    @trigger('back', area: @area)

  showForm: ->
    $('#draw-polygon-notice').slideUp()
    $('#validation-attributes').slideDown()

  # Show conditional fields based on habitat selected
  showAttributesForHabitat: (event)=>
    habitatSelected = $(event.srcElement).val()
    $('.conditional').slideUp()

    if habitatSelected == ''
      $('#create-analysis').slideUp()
    else
      $(".conditional.#{habitatSelected}").slideDown()
      $('#create-analysis').slideDown() if $('[name=action]').val() != ''

  # Show conditional fields based on action selected
  showAttributesForAction: (event)=>
    actionSelected = $(event.srcElement).val()
    if actionSelected == 'add'
      $('#validation-details').slideDown()
      $('#create-analysis').slideDown() if $('[name=habitat]').val() != ''
    else if actionSelected == 'delete'
      $('#validation-details').slideUp()
      $('#create-analysis').slideDown() if $('[name=habitat]').val() != ''
    else
      $('#validation-details').slideUp()
      $('#create-analysis').slideUp()

  # Unset values in conditional fields which are hidden
  clearUnselectedFields: ->
    $('.conditional:hidden input').val('')
    $('.conditional:hidden select').val([])

  close: () ->
    @polygonDraw.disable()
    @map.off('draw:poly-created')
    @map.off('draw:polygon:add-vertex')
    @map.removeLayer(@mapPolygon) if @mapPolygon?
    @removeLayerControl(@map)
    @removeTileLayers(@map)

_.extend(BlueCarbon.Views.AddValidationView::, BlueCarbon.Mixins.AreaMapLayers)
