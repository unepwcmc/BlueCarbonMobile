window.BlueCarbon ||= {}
window.BlueCarbon.Collections ||= {}

class BlueCarbon.Collections.Validations extends Backbone.SyncableCollection
  model: BlueCarbon.Models.Validation
  initialize: (models, options) ->
    @area = options.area
    super
  
  doSqliteSync: (method, collection, options) =>
    sql = ""
    switch method
      when "read"
        sql =
          """
            SELECT *
            FROM #{collection.model::constructor.name}
            WHERE area_id="#{collection.area.get('id')}";
          """
     
    BlueCarbon.SQLiteDb.transaction(
      (tx) =>
        tx.executeSql(sql, [], (tx, results) =>
          options.success.call(@, results, 'success', tx)
        )
      , (tx, error) =>
        options.error.apply(@, arguments)
    )
