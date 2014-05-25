'use strict'
db = require(process.cwd() + "/database")
User = db.user
Book = db.book
###*
 * ME METHODS
###

showBook = (request, reply) ->
  if !!request.params.all
    Book.findById(
      request.params.id
    ).populate('owner','buyers')
    .exec((err, docs) ->
      return reply({"flash":err}) if err
      reply(docs)
    )
  if !!request.params.id
    Book.findById(
      request.params.id
    , (err, docs) ->
      return reply({"flash":err}) if err
      reply(docs)
    )
listBook = (request, reply)->
  Book.find({}, (err, docs) ->
    return reply({"flash":err}) if err
    reply(docs)
  )

createBook = (request, reply) ->
  book = new Book(request.payload)
  book.save((err, doc) ->
    return reply({"flash":err}) if err
    reply(doc)
  )

updateBook = (request, reply) ->
  delete request.payload._id
  Book.update(
    _id:request.params.id
  ,request.payload
  ).exec((err, docs) ->
    return reply({"flash":err}) if err
    reply(docs)
  )

deleteBook = (request, reply) ->
  Book.remove
    _id:request.params.id
  , (err, docs) ->
    return reply({"flash":err}) if err
    flash =
      message:"removed"
    reply(flash)

findBook = (request, reply) ->
  Book.find(request.query, (err, docs) ->
    return reply({"flash":err}) if err
    reply(docs)
  )

uploadImage = (request,reply)->
  console.log request
  flow = require(process.cwd() + "/database/plugins/flow")('books/images/')
  flow.post request, (status, filename, original_filename, identifier) ->
    console.log "POST", status, original_filename, identifier
    reply([status, original_filename, identifier])

###*
 * ROUTER
###
module.exports = (server) ->
  prefix="/api/v1/book"
  ###*
   * book one populate
  ###
  server.route
    method: "GET"
    path: "#{prefix}"
    handler: listBook

  server.route
    method: "GET"
    path: "#{prefix}/{id}/{all?}"
    handler: showBook
  ###*
   * update book
  ###
  server.route
    method: "POST"
    path: "#{prefix}"
    config:
      auth: 'token'
    handler: createBook
  ###*
   * update book
  ###
  server.route
    method: "PUT"
    path: "#{prefix}/{id}"
    handler: updateBook
  server.route
    method: "POST"
    path: "#{prefix}/{id}"
    handler: uploadImage
  ###*
   * delete
  ###
  server.route
    method: "DELETE"
    path: "#{prefix}/{id}"
    handler: deleteBook
  ###*
   * Find
  ###
  server.route
    method: "GET"
    path: "#{prefix}/find"
    handler: findBook