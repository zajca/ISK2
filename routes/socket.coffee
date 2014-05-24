'use strict'
db = require(process.cwd() + "/database")
User = db.user
Session = db.session

###*
 * ROUTER
###
module.exports = (server) ->
  login: (data)->
  stateChange: (data)->
  logout: ()->