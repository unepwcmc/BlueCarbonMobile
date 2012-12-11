class Backbone.SyncableCollection extends Backbone.Collection
  localFetch: (options) ->
    # This method copies the default backbone behavior, 
    # but uses our sqliteSync instead of backbone.sync
    options = (if options then _.clone(options) else {})
    options.parse = true  if options.parse is undefined
    collection = this
    success = options.success
    options.success = (resp, status, xhr) ->
      method = (if options.update then "update" else "reset")
      collection[method] collection.parse(resp, xhr), options
      success collection, resp, options  if success

    @sqliteSync "read", this, options

  localSave: (options) ->
    @each((model)->
      model.localSave(
        error: (a,b,c) ->
          console.log arguments
      )
    )

  sqliteSync: (method, collection, options) ->
    Backbone.SyncableModel::createTableIfNotExist.call(
      collection.model::,
        success: =>
          @doSqliteSync(method, collection, options)
        error: (a,b,c) =>
          console.log("Error confirming existence of DB for collection #{collection.model.constructor.name}:")
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