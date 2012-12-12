window.BlueCarbon ||= {}
window.BlueCarbon.Collections ||= {}

class BlueCarbon.Collections.Areas extends Backbone.SyncableCollection
  model: BlueCarbon.Models.Area
  
  url: 'http://bluecarbon.unep-wcmc.org/areas.json'

  doSqliteSync: (method, collection, options) =>
    sql = ""
    switch method
      when "read"
        sql =
          """
            SELECT *
            FROM #{collection.model::constructor.name}
          """
     
    BlueCarbon.SQLiteDb.transaction(
      (tx) =>
        tx.executeSql(sql, [], (tx, results) =>
          options.success.call(@, results, 'success', tx)
        )
      , (tx, error) =>
        options.error.apply(@, arguments)
    )

  parse: (data, response)->
    # Don't overwrite attributes from local storage
    #for layer in @get('mbtiles')
    super
