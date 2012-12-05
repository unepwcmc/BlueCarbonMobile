class Backbone.SyncableModel extends Backbone.Model
  initialize: (options) ->
    @db = window.BlueCarbon.SQLiteDb
    super

  save: (key, value, options) ->
    this.sync = this.sqliteSync
    super

  fetch: (options) ->
    this.sync = this.sqliteSync
    super

  pushToServer: (options) ->
    super.save()

  sqliteSync: (method, model, options) ->
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
          values.push(val)

        sql =
          """
            INSERT INTO #{model.constructor.name}
            ( #{fields.join(", ")} )
            VALUES ( #{values.join(", ")} )
          """
      when "update"
        sql = []
        for attr, val of attrs
          sql.push(
            """
              UPDATE #{model.constructor.name}
              SET #{attr}=#{val}
              WHERE id="#{attrs['id']}"
            """
          )
        sql = sql.join("; ")
      when "read"
        sql =
          """
            SELECT #{Object.keys(attrs)}
            FROM #{model.constructor.name}
            WHERE id="#{attrs['id']}"
          """
      when "delete"
        sql =
          """
            DELETE FROM #{model.constructor.name}
            WHERE id="#{attrs['id']}"
          """

    @db.transaction(
      (tx) =>
        tx.executeSql(sql, [], (tx, results) =>
          options.success.apply(@, arguments)
        )
      , (tx, error) =>
        options.error.apply(@, arguments)
    )
