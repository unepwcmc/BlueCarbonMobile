class Backbone.SyncableCollection extends Backbone.Collection
  localFetch: (options) ->
    @sync = @sqliteSync
    @fetch.apply(@, arguments)
    @sync = Backbone.sync

  sqliteSync: (method, collection, options) ->
    Backbone.SyncableModel::createTableIfNotExist.call(
      collection.model::,
        success: =>
          @doSqliteSync(method, collection, options)
        error: (a,b,c) =>
          console.log('Error fetching collection:')
          console.log arguments
          options.error(error)
    )

  parse: (results,tx)->
    if results.rows?
      i = 0
      jsonResults = []
      while results.rows.item(i)
        jsonResults.push(results.rows.item(i))
        i = i + 1
      return jsonResults
    else
      super

  doSqliteSync: (method, collection, options) =>
    alert("Collection #{collection.constructor.name} must implement a doSqliteSync method which provides backbone.sync behavior, but to SQL")
