'use strict'
db = require(process.cwd() + "/database")
User = db.user
Book = db.book
###*
 * ME METHODS
###

###*
 * show loged user info
 * @param  {[type]} request [description]
 * @param  {[type]} reply   [description]
 * @return {[type]}         [description]
###
showMe   = (request, reply) ->
  reply.view "store"

###*
 * update loged user
 * @param  {[type]} request [description]
 * @param  {[type]} reply   [description]
 * @return {[type]}         [description]
###
updateMe   = (request, reply) ->
  reply.view "admin"

###*
 * list of book for actual user
 * @param  {[type]} request [description]
 * @param  {[type]} reply   [description]
 * @return {[type]}         [description]
###
listBook  = (request, reply) ->
  reply.view "editor"

###*
 * single book for actual user
 * @param  {[type]} request [description]
 * @param  {[type]} reply   [description]
 * @return {[type]}         [description]
###
showBook  = (request, reply) ->
  reply.view "editor"

###*
 * update book of actual user
 * @param  {[type]} request [description]
 * @param  {[type]} reply   [description]
 * @return {[type]}         [description]
###
updateBook  = (request, reply) ->
  reply.view "editor"

###*
 * list of projects for actual user
 * @param  {[type]} request [description]
 * @param  {[type]} reply   [description]
 * @return {[type]}         [description]
###
listProject   = (request, reply) ->
  reply.view "admin"

###*
 * create new project
 * @param  {[type]} request [description]
 * @param  {[type]} reply   [description]
 * @return {[type]}         [description]
###
createProject   = (request, reply) ->
  reply.view "admin"

###*
 * show single project
 * @param  {[type]} request [description]
 * @param  {[type]} reply   [description]
 * @return {[type]}         [description]
###
showProject   = (request, reply) ->
  reply.view "admin"

###*
 * update project for actual user
 * @param  {[type]} request [description]
 * @param  {[type]} reply   [description]
 * @return {[type]}         [description]
###
updateProject   = (request, reply) ->
  reply.view "admin"

###*
 * ROUTER
###
module.exports = (server) ->
  prefix="/api/v1/me"
  ###*
   * show info
  ###
  server.route
    method: "GET"
    path: "#{prefix}"
    config:
      auth: 'token'
    handler: showMe

  ###*
   * update me
  ###
  server.route
    method: "PUT"
    path: "#{prefix}"
    config:
      auth: 'token'
    handler: updateMe

  ###*
   * my books
  ###
  server.route
    method: "GET"
    path: "#{prefix}/book"
    config:
      auth: 'token'
    handler: listBook

  ###*
   * my book
  ###
  server.route
    method: "GET"
    path: "#{prefix}/book/:id"
    config:
      auth: 'token'
    handler: showBook

  ###*
   * update my book
  ###
  server.route
    method: "PUT"
    path: "#{prefix}/book/:id"
    config:
      auth: 'token'
    handler: updateBook

  ###*
   * my projects
  ###
  server.route
    method: "GET"
    path: "#{prefix}/project/:id"
    config:
      auth: 'token'
    handler: showProject

  ###*
   * my projects
  ###
  server.route
    method: "GET"
    path: "#{prefix}/project"
    config:
      auth: 'token'
    handler: listProject

  ###*
   * create new project
  ###
  server.route
    method: "POST"
    path: "#{prefix}/project"
    config:
      auth: 'token'
    handler: createProject

  ###*
   * update project
  ###
  server.route
    method: "PUT"
    path: "#{prefix}/project/:id"
    config:
      auth: 'token'
    handler: updateProject