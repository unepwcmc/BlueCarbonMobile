window.BlueCarbon ||= {}
window.BlueCarbon.Models ||= {}

class BlueCarbon.Models.Area extends Backbone.SyncableModel
  defaults:
    downloaded_data: false

  schema: ->
    "id INTEGER, title TEXT, coordinates TEXT, mbtiles TEXT, error TEXT, downloaded_data BOOLEAN, PRIMARY KEY (id)"
