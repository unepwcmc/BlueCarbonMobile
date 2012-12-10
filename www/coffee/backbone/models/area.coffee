window.BlueCarbon ||= {}
window.BlueCarbon.Models ||= {}

class BlueCarbon.Models.Area extends Backbone.SyncableModel
  schema: ->
    "id INTEGER, title TEXT, coordinates TEXT, mbtiles TEXT, error TEXT, PRIMARY KEY (id)"
