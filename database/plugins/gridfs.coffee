mongoose = require "mongoose"

mongo = mongoose.mongo
GridStore = mongoose.mongo.GridStore
Grid      = mongoose.mongo.Grid
ObjectID = mongoose.mongo.BSONPure.ObjectID
randomstring = require("randomstring")

parse = (options) ->
  opts = {}
  if options.length > 0
    opts = options[0]
  if !opts.metadata
    opts.metadata = {}
  opts

module.exports =
  get: (id, fn) ->
    db = mongoose.connection.db
    id = new ObjectID(id)
    store = new GridStore(db, id, "r",
      root: "fs"
    )
    store.open (err, store) ->
      return fn(err)  if err
      # band-aid
      if "#{store.filename}" == "#{store.fileId}" and store.metadata and store.metadata.filename
        store.filename = store.metadata.filename
      fn null, store

  put: (buf, name, options..., fn) ->
    db = mongoose.connection.db
    options = parse(options)
    options.metadata.filename = name
    new GridStore(db, randomstring.generate(), "w", options).open((err, file) ->
      return fn(err)  if err
      file.write(buf, true, fn)
    )

  putFile: (path, name, options, fn) ->
    db = mongoose.connection.db
    options = parse(options)
    options.metadata.filename = name
    new GridStore(db, name, "w", options).open (err, file) ->
      return fn(err)  if err
      file.writeFile path, fn