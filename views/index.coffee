'use strict'

###*
 * RETURN VIEWS
###
store   = (request, reply) ->
  reply.view "store"

editor  = (request, reply) ->
  reply.view "editor"

create  = (request, reply) ->
  reply.view "create"

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
      path: "/me/{path*}"
      handler: store
    server.route
      method: "GET"
      path: "/register/{path*}"
      handler: store

    server.route
      method: "GET"
      path: "/editor/{path*}"
      handler: editor

    server.route
      method: "GET"
      path: "/create/{path*}"
      handler: create

    server.route
      method: "GET"
      path: "/admin/{path*}"
      handler: admin