mongoose = require("mongoose")
# acl = require('acl')

# Enable Query::paginate
require "./plugins/paginate"

module.exports =
  #setupDB
  setUp: (config)->
    connectionString = "mongodb://#{config.db.host}:#{config.db.port}/#{config.db.name}"
    console.log connectionString
    db = mongoose.connect(config.db.host,config.db.name)

  # acl:  require "./acl"
  user: require "./schema/user"
  book: require "./schema/book"