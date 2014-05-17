mongoose = require("mongoose")
GridStore = mongoose.mongo.GridStore
Grid = mongoose.mongo.Grid
ObjectID = mongoose.mongo.BSONPure.ObjectID

parse = (options) ->
  opts = {}
  if options.length > 0
    opts = options[0]
  else
    opts = options
  opts.metadata = {}  unless opts.metadata
  opts

exports.getGridFile = (id, fn) ->
  db = mongoose.connection.db
  id = new ObjectID(id)
  store = new GridStore(db, id, "r",
    root: "fs"
  )
  store.open (err, store) ->
    if err
      fn err
    else
      if (store.filename.toString() is store.fileId.toString()) and store.metadata and store.metadata.filename
        store.filename = store.metadata.filename
        fn null, store

exports.putGridFile = (buf, name, options, fn) ->
  db = mongoose.connection.db
  options = parse(options)
  options.metadata.filename = name
  new GridStore(db, name, "w", options).open (err, file) ->
    if err
      fn err
    else
      file.write buf, true, fn

exports.putGridFileByPath = (path, name, options, fn) ->
  db = mongoose.connection.db
  options = parse(options)
  options.metadata.filename = name
  new GridStore(db, name, "w", options).open (err, file) ->
    if err
      fn err
    else
      file.writeFile path, fn

exports.deleteGridFile = (id, fn) ->
  console.log "Deleting GridFile " + id
  db = mongoose.connection.db
  id = new mongoose.mongo.BSONPure.ObjectID(id)
  store = new GridStore(db, id, "r",
    root: "fs"
  )
  store.unlink (err, result) ->
    return fn(err)  if err
    fn null