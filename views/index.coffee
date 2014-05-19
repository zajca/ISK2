'use strict'

###*
 * RETURN VIEWS
###
store   = (request, reply) ->
  reply.view "store"

editor  = (request, reply) ->
  reply.view "editor"

create  = (request, reply) ->
  reply.view "editor"

admin   = (request, reply) ->
  reply.view "admin"

###*
 * ROUTER
###
module.exports =
  router: (server) ->
    server.route
      method: "GET"
      path: "/"
      handler: store
    server.route
      method: "GET"
      path: "/login"
      handler: store
    server.route
      method: "GET"
      path: "/book/{path*}"
      handler: store
    server.route
      method: "GET"
      path: "/user/{path*}"
      handler: store


    server.route
      method: "GET"
      path: "/editor"
      handler: editor

    server.route
      method: "GET"
      path: "/create"
      handler: create

    server.route
      method: "GET"
      path: "/admin"
      handler: admin