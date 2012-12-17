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

  pushToServer: ->
    @each (validation) ->
      validation.save({},
        success: ->
          console.log "successfully pushed to server"
          validation.localDestroy(
            success: ->
              alert('destroyed')
            error: (a,b,c) ->
              console.log("failed to delete area with:")
              console.log arguments
          )
        error: (a,b,c)->
          console.log("failed to upload area with:")
          console.log arguments
      )
