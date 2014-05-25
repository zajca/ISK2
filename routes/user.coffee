'use strict'
db = require(process.cwd() + "/database")
User = db.user
Book = db.book
###*
 * ME METHODS
###

showUser = (request, reply) ->
  if !!request.params.all
    User.findById(
      request.params.id
    ).populate('*'
    ).exec((err, docs) ->
      return reply({"flash":err}) if err
      reply(docs)
    )
  if !!request.params.id
    User.findById(
      request.params.id
    , (err, docs) ->
      return reply({"flash":err}) if err
      reply(docs)
    )
listUser = (request, reply)->
  User.find({}, (err, docs) ->
    return reply({"flash":err}) if err
    reply(docs)
  )

createUser = (request, reply) ->
  user = new User(request.payload)
  user.save((err, doc) ->
    return reply({"flash":err}) if err
    reply(doc)
  )

updateUser = (request, reply) ->
  delete request.payload._id
  User.update(
    _id:request.params.id
  ,request.payload
  ).exec((err, docs) ->
    return reply({"flash":err}) if err
    reply(docs)
  )

deleteUser = (request, reply) ->
  User.remove
    _id:request.params.id
  , (err, docs) ->
    return reply({"flash":err}) if err
    flash =
      message:"removed"
    reply(flash)

findUser = (request, reply) ->
  User.find(request.query, (err, docs) ->
    return reply({"flash":err}) if err
    reply(docs)
  )
###*
 * ROUTER
###
prefix="/api/v1/user"
module.exports = (server) ->
  ###*
   * user one populate
  ###
  server.route
    method: "GET"
    path: "#{prefix}"
    handler: listUser

  server.route
    method: "GET"
    path: "#{prefix}/{id}/{all?}"
    handler: showUser
  ###*
   * update user
  ###
  server.route
    method: "POST"
    path: "#{prefix}"
    handler: createUser
  ###*
   * update user
  ###
  server.route
    method: "PUT"
    path: "#{prefix}/{id}"
    handler: updateUser
  ###*
   * delete
  ###
  server.route
    method: "DELETE"
    path: "#{prefix}/{id}"
    handler: deleteUser
  ###*
   * Find
  ###
  server.route
    method: "GET"
    path: "#{prefix}/find"
    handler: findUser