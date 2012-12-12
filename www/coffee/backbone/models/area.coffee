window.BlueCarbon ||= {}
window.BlueCarbon.Models ||= {}

class BlueCarbon.Models.Area extends Backbone.SyncableModel
  schema: ->
    "id INTEGER, title TEXT, coordinates TEXT, mbtiles TEXT, error TEXT, PRIMARY KEY (id)"

  downloadData: ->
    for layer in @get('mbtiles')
      ft = new FileTransfer()

      ft.download layer.url, @filenameForLayer(layer),
        (fileEntry)=>
          @layerDownloaded(layer, fileEntry)
        , (error) ->
          alert "unable to download #{layer.habitat}"
          console.log error

  filenameForLayer: (layer) ->
    fs.root.fullPath + "/" + layer.habitat

  layerDownloaded: (layer, fileEntry) =>
    console.log "downloaded #{layer.habitat}"
    layer.downloadedAt = (new Date()).getTime()
    mbTiles = @get('mbtiles')
    for index, storedLayer in mbTiles
      if storedLayer.habitat == layer.habitat
        mbTiles[index] = layer
    @set('mbtiles', mbTiles)
    @localSave()

  downloadState: () ->
    for layer in @get('mbtiles')
      if layer.status == 'generating'
        return 'data generating'
      if !layer.downloadedAt?
        return 'no data'
      console.log "comparing downloadedAt(#{layer.downloadedAt}) < last_generated_at(#{layer.last_generated_at})"
      if layer.downloadedAt < layer.last_generated_at
        return 'out of date'
    return "ready"
