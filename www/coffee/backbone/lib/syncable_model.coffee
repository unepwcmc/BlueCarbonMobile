class Backbone.SyncableModel extends Backbone.Model
  save: (key, value, options) ->
    this.sync = this.sqliteSync
    super

  fetch: (options) ->
    this.sync = this.sqliteSync
    super

  pushToServer: (options) ->
    super.save()

  sqliteSync: (method, model, options) ->
    @createTableIfNotExist(
      success: =>
        @doSqliteSync(method, model, options)
      error: (error) =>
        options.error(error)
    )

  doSqliteSync: (method, model, options) ->
    attrs = model.toJSON()

    sql = ""
    switch method
      when "create"
        fields = []
        values = []

        for attr, val of attrs
          if _.isArray(val) or _.isObject(val)
            val = JSON.stringify(val)

          fields.push(attr)
          values.push("\"#{val}\"")

        sql =
          """
            INSERT INTO #{model.constructor.name}
            ( #{fields.join(", ")} )
            VALUES ( #{values.join(", ")} );
          """
      when "update"
        sql = []
        for attr, val of attrs
          sql.push(
            """
              UPDATE #{model.constructor.name}
              SET #{attr}="#{val}"
              WHERE id="#{attrs['id']}"
            """
          )
        sql = sql.join("; ")
      when "read"
        sql =
          """
            SELECT #{Object.keys(attrs)}
            FROM #{model.constructor.name}
            WHERE id="#{attrs['id']}";
          """
      when "delete"
        sql =
          """
            DELETE FROM #{model.constructor.name}
            WHERE id="#{attrs['id']}";
          """

    BlueCarbon.SQLiteDb.transaction(
      (tx) =>
        tx.executeSql(sql, [], (tx, results) =>
          options.success.apply(@, arguments)
        )
      , (tx, error) =>
        options.error.apply(@, arguments)
    )

  createTableIfNotExist: (options) =>
    console.log "confirming existence of #{@constructor.name} table"
    try
      fail++
    catch err
      console.log(err.stack)
    
    unless @schema?
      alert("Model #{@constructor.name} must implement a this.schema() method, containing a SQLite comma separated string of 'name TYPE, name2 TYPE2...' so the DB can be init")
      return options.error()

    sql = "CREATE TABLE IF NOT EXISTS #{@constructor.name} (#{@schema()})"
    BlueCarbon.SQLiteDb.transaction(
      (tx) =>
        tx.executeSql(sql, [], (tx, results) =>
          options.success.apply(@, arguments)
        )
      , (tx, error) =>
        options.error.apply(@, arguments)
    )
