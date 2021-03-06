mongoose = require("mongoose")
# mongo = require('mongodb')
# Grid = require('gridfs-stream')
#Grid.mongo = mongoose.mongo
# acl = require('acl')

# Enable Query::paginate
require "./plugins/paginate"

module.exports =
  #setupDB
  setUp: (config)->
    connectionString = "mongodb://#{config.db.host}:#{config.db.port}/#{config.db.name}"
    db = mongoose.connect(config.db.host,config.db.name)
    # b = new mongo.Db(config.db.name, new mongo.Server(config.db.host, config.db.port));
    # gfs = Grid(b, mongo)
  # acl:  require "./acl"
  user: require "./schema/user"
  book: require "./schema/book"
  gfs: require "./plugins/gridfs"
  session: require "./schema/session"
  order: require "./schema/order"
  troubleshot: require "./schema/troubleshot"
  branch: require "./schema/branch"
  config: require "./schema/config"
  log: require "./schema/log"
  pages: require "./schema/pages"
  project: require "./schema/project"
  file: require "./schema/file"