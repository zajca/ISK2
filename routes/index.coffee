'use strict'
crypto = require "crypto"
db = require(process.cwd() + "/database")
User = db.user

loginUser = (request, reply) ->
  email = request.payload.email
  password = request.payload.password
  console.log User
  User.findOne({email:email}, (err, user)->
    user.validPassword(password, (isValid)->
      console.log(isValid)
      user.createToken((token)->
        reply(
          valid:isValid
          token:token
        )
      )
    )
  )

init = (request,reply)->
  user = new User(
    name:"test"
    email:"zajca@zajca.cz"
    password:"test"
    surname:"test"
    tel:"776598983"
  )
  user.save((err)->
    return console.log(err) if err
    reply(user)
  )

###*
 * ROUTER
###
prefix="/api/v1"
module.exports =
  load: (server) ->
    # require("./me")(server)
    server.route
      method: "POST"
      path: "#{prefix}/login"
      handler: loginUser
    server.route
      method: "GET"
      path: "#{prefix}/init"
      handler: init
    # console.log "dsadas",server
  validate: (decodedToken, callback) ->
    account = User.findOne({email:decodedToken.email})
    return callback(null, false)  unless user
    callback err, isValid,
      name: account.email
