'use strict'
crypto = require "crypto"
gm = require('gm')
Boom = require('boom')
db = require(process.cwd() + "/database")
User = db.user
# File = db.file
File=db.gfs

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
currentpositionApi =
  fs: require("fs")
  multiparty: require("multiparty")
  uploadFiles: (req, reply) ->
    form = new currentpositionApi.multiparty.Form()
    form.parse req.payload, (err, fields, files) ->
      currentpositionApi.fs.readFile files.upload[0].path, (err, data) ->
        newpath = __dirname + "/" + files.upload[0].originalFilename
        currentpositionApi.fs.writeFile newpath, data, (err) ->
          if err
            console.log err
          else
            console.log files
      console.log files

upload = (request, reply) ->
  console.log request.payload
  Book.findById(536baa0fba1ef130751ea61a)
  reply(request.payload.file)
  # console.log request.payload.file.length
#   if(params.file.mime !== 'image/png' && params.file.mime !== 'image/jpeg' && params.file.mime !== 'image/gif') {
#     callbacks.uploadFailure('Wrong file type');
#     return;
# }
#   File.put(request.payload.file,request.payload.flowFilename,{},(err,doc)->
#     return reply(err) if err
#     console.log "put cb"
#     reply(doc)
#   )
  # reply(request)
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
      config:
        handler: upload
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