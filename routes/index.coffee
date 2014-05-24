'use strict'
crypto = require "crypto"
gm = require('gm')
Boom = require('boom')
db = require(process.cwd() + "/database")
User = db.user
File = db.file

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
uploadGrid = (request,reply)->
  gm(request.payload.file,request.payload.flowFilename).resize(200, 309).noProfile().toBuffer((err,buf)->
    return reply(Boom.badImplementation()) if err
    File.put(buf,request.payload.flowFilename,{},(err,doc)->
      console.log "put cb"
      reply(doc.currentChunk)
    )
  )

###*
 * ROUTER
###
prefix="/api/v1"
module.exports =
  load: (server) ->
    require("./book")(server)
    require("./me")(server)
    require("./user")(server)
    # require("./socket")(server)
    server.route
      method: "POST"
      path: "#{prefix}/login"
      handler: loginUser
    server.route
      method: "GET"
      path: "#{prefix}/init"
      handler: init
    server.route
      method: "GET"
      path: "#{prefix}/login"
      config:
        auth: 'token'
      handler: (response,reply)->
        reply({valid:true})
    ###*
     * FILE UPLOAD
    ###
    server.route
      method: "POST"
      path: "#{prefix}/file"
      handler: uploadGrid
    server.route
      method: "GET"
      path: "#{prefix}/file"
      handler: (request,reply)->
        reply(Boom.notFound())
    server.route
      method: "GET"
      path: "#{prefix}/file/{id}"
      handler: (request,reply)->
        File.get(request.params.id,(err,res)->
          return reply(Boom.notFound()) if err
          reply(res);
        )
    # console.log "dsadas",server
  validate: (decodedToken, callback) ->
    User.findOne({email:decodedToken.email},(err,user)->
      return callback(null, false) if err
      callback(err, true, user)
    )