# Mixin designed for views, adds area map layer behavior
# Add to a view using:
#   _.extend(MyView, BlueCarbon.Mixins.AreaMapLayers)
window.BlueCarbon ||= {}
window.BlueCarbon.Mixins ||= {}

BlueCarbon.Mixins.AreaMapLayers = 
  addMapLayers: (area, map)->
    @removeTileLayers()
    @tileLayers ||= []
    for layer in area.tileLayers()
      console.log "adding tile layer for #{layer.mbtileLocation}"
      db = window.sqlitePlugin.openDatabase(layer.mbtileLocation, "1.0", "Tiles", 2000000)
      tileLayer = new L.TileLayer.MBTiles(db,
        tms: true
      ).addTo(map)
      @tileLayers.push tileLayer

  removeTileLayers: (map)->
    return unless @tileLayers?
    for layer in @tileLayers
      map.removeLayer(layer)

