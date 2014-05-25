'use strict'
db = require(process.cwd() + "/database")
User = db.user
Book = db.book
Order = db.order
Project = db.project
###*
 * ME METHODS
###
showMe   = (request, reply) ->
  User.findById(request.auth.credentials._id)
  .populate('favourite_books','whished_books')
  .exec((err, docs) ->
    return reply({"flash":err}) if err
    delete docs.password
    delete docs.passwordSalt
    reply(docs)
  )
updateMe   = (request, reply) ->
  delete request.payload._id
  console.log "updateMe",request.payload
  #update
  User.update(
    _id:request.auth.credentials._id
  ,request.payload
  ).exec((err, docs) ->
    return reply({"flash":err}) if err
    delete docs.password
    delete docs.passwordSalt
    reply(docs)
  )
listBook  = (request, reply) ->
  reply.view "editor"
showBook  = (request, reply) ->
  reply.view "editor"
updateBook  = (request, reply) ->
  reply.view "editor"
listProject   = (request, reply) ->
  Project.find({owner:request.auth.credentials._id})
  .populate('projects')
  .exec((err, doc) ->
    return reply({"flash":err}) if err
    reply(doc)
  )
createProject   = (request, reply) ->
  project = new Project(request.payload)
  User.findById(request.auth.credentials._id)
  .exec((err, user) ->
    return reply({"flash":err}) if err
    project.owner = user
    project.save((err, doc) ->
      return reply({"flash":err}) if err
      reply(doc)
    )
  )
showProject   = (request, reply) ->
  Project.findById(request.params.id)
  .exec((err, doc) ->
    return reply({"flash":err}) if err
    reply(doc)
  )
updateProject   = (request, reply) ->
  console.log "updateProject",request.payload._id
  id = request.payload._id
  delete request.payload._id
  Project.update(
    _id:id
  ,request.payload
  ).exec((err, docs) ->
    return reply({"flash":err}) if err
    reply(docs)
  )
addFavourite = (request, reply) ->
  User.findById(request.auth.credentials._id, (err, user) ->
    return reply({"flash":err}) if err
    Book.findById(request.params.id,(err,book)->
      user.favourite_books.push(book)
      user.save((err)->
        return reply({"flash":err}) if err
        reply({flash:{message:"OK"}})
      )
    )
  )
removeFavourite = (request, reply) ->
  User.findById(request.auth.credentials._id, (err, user) ->
    return reply({"flash":err}) if err
    Book.findById(request.params.id,(err,book)->
      user.favourite_books.remove(book)
      user.save((err)->
        return reply({"flash":err}) if err
        reply({flash:{message:"OK"}})
      )
    )
  )
addWhish = (request, reply) ->
  User.findById(request.auth.credentials._id, (err, user) ->
    return reply({"flash":err}) if err
    Book.findById(request.params.id,(err,book)->
      user.whished_books.push(book)
      user.save((err)->
        return reply({"flash":err}) if err
        reply({flash:{message:"OK"}})
      )
    )
  )
removeWhish = (request, reply) ->
  User.findById(request.auth.credentials._id, (err, user) ->
    return reply({"flash":err}) if err
    Book.findById(request.params.id,(err,book)->
      user.whished_books.remove(book)
      user.save((err)->
        return reply({"flash":err}) if err
        reply({flash:{message:"OK"}})
      )
    )
  )

uploadImage = (request,reply)->
  console.log request
  flow = require(process.cwd() + "/database/plugins/flow")('projects/'+request.params.id)
  flow.post request, (status, filename, original_filename, identifier) ->
    console.log "POST", status, original_filename, identifier
    reply([status, original_filename, identifier])

prefix="/api/v1/me"
routes = [
  {
    method: "GET"
    path: "#{prefix}"
    config:
      auth: 'token'
    handler: showMe
  }
  {
    method: "PUT"
    path: "#{prefix}"
    config:
      auth: 'token'
    handler: updateMe
  }
  {
    method: "GET"
    path: "#{prefix}/book"
    config:
      auth: 'token'
    handler: listBook
  }
  {
    method: "GET"
    path: "#{prefix}/book/{id}"
    config:
      auth: 'token'
    handler: showBook
  }
  {
    method: "PUT"
    path: "#{prefix}/book/{id}"
    config:
      auth: 'token'
    handler: updateBook
  }
  {
    method: "GET"
    path: "#{prefix}/project/{id}"
    config:
      auth: 'token'
    handler: showProject
  }
  {
    method: "GET"
    path: "#{prefix}/project"
    config:
      auth: 'token'
    handler: listProject
  }
  {
    method: "POST"
    path: "#{prefix}/project"
    config:
      auth: 'token'
    handler: createProject
  }
  {
    method: "POST"
    path: "#{prefix}/project/{id}/file"
    config:
      auth: 'token'
    handler: uploadImage
  }
  {
    method: "PUT"
    path: "#{prefix}/project/{id}"
    config:
      auth: 'token'
    handler: updateProject
  }
  {
    method: "PUT"
    path: "#{prefix}/favourite/{id}"
    config:
      auth: 'token'
    handler: addFavourite
  }
  {
    method: "DELETE"
    path: "#{prefix}/favourite/{id}"
    config:
      auth: 'token'
    handler: removeFavourite
  }
  {
    method: "PUT"
    path: "#{prefix}/whish/{id}"
    config:
      auth: 'token'
    handler: addWhish
  }
  {
    method: "DELETE"
    path: "#{prefix}/whish/{id}"
    config:
      auth: 'token'
    handler: removeWhish
  }
]
###*
 * ROUTER
###
module.exports = (server) ->
  server.route(routes)

