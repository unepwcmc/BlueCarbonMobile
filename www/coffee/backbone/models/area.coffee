window.BlueCarbon ||= {}
window.BlueCarbon.Models ||= {}

class BlueCarbon.Models.Area extends Backbone.SyncableModel
  schema: ->
    "id INTEGER, title TEXT, coordinates TEXT, mbtiles TEXT, error TEXT, PRIMARY KEY (id)"

  downloadData: ->
    for layer in @get('mbtiles')
      ft = new FileTransfer()

      boundSuccess = (() =>
        _layer = layer
        return (fileEntry)=>
          @layerDownloaded(_layer, fileEntry)
      )()
      boundError = (() =>
        _layer = layer
        return (error) ->
          alert "unable to download #{_layer.habitat}"
          console.log error
      )()
      ft.download layer.url, @filenameForLayer(layer), boundSuccess, boundError

  filenameForLayer: (layer) ->
    fs.root.fullPath + "/" + layer.habitat

  layerDownloaded: (layer, fileEntry) =>
    console.log "downloaded #{layer.habitat}"
    layer.downloadedAt = (new Date()).getTime()
    mbTiles = @get('mbtiles')
    for storedLayer, index in mbTiles
      if storedLayer.habitat == layer.habitat
        mbTiles[index] = layer
    @set('mbtiles', mbTiles)
    @localSave()

  downloadState: () ->
    for layer in @get('mbtiles')
      if layer.status == 'pending' || layer.status == 'generating'
        return 'data generating'
      if !layer.downloadedAt?
        return 'no data'
      console.log "comparing downloadedAt(#{layer.downloadedAt}) < last_generated_at(#{Date.parse(layer.last_generated_at)})"
      if layer.downloadedAt < Date.parse(layer.last_generated_at)
        return 'out of date'
    return "ready"

  lastDownloaded: ->
    lowestDownloaded = ""
    for layer in @get('mbtiles')
      if layer.downloadedAt?
        if !_.isNumber(lowestDownloaded) || layer.downloadedAt < lowestDownloaded
          lowestDownloaded = layer.downloadedAt
    if (typeof lowestDownloaded) == 'string'
      return ""
    else
      lowestDownloaded = new Date(lowestDownloaded)
      return "#{lowestDownloaded.getFullYear()}/#{lowestDownloaded.getMonth()+1}/#{lowestDownloaded.getDate()}"
