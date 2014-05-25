###*
 * LOAD MODULES
###
Hapi    = require("hapi")
SocketIO= require("socket.io")
jwt = require('jsonwebtoken')

###*
 * AUTH
###
privateKey = 'YourApplicationsPrivateKey';


###*
 * LOAD APP MODULES
###
views   = require("./views")
require("./config").setUp(process.env.ENV)
config  = require("./config").getConfig(process.env.ENV)

#DB
db = require('./database')
db.setUp(config)
Order = db.order
User = db.user
File = db.file
Book = db.book
Troubleshot: db.troubleshot
Branch: db.branch
Config: db.config
Log: db.log
Pages: db.pages
Project: db.project

###*
 * MAIN SERVER CONFIG
###
app =
  main: ->
    options =
      views:
        engines:
          jade: "jade"
        # path: __dirname + "/build/partials"
        path: __dirname + "/views"
        compileOptions:
          pretty: true

    server = new Hapi.Server(config.app.port, options)
    ###*
     * JWT AUTH
    ###
    server.pack.require "hapi-auth-jwt", (err) ->
      server.auth.strategy('token', 'jwt', { key: config.app.privateKey,  validateFunc: require("./routes").validate })

      ###*
       * Nastaveni routeru
      ###
      require("./config").router(server)
      require("./routes").load(server)
      views.router(server)

      server.start ->
        io = SocketIO.listen(server.listener)
        io.on 'connection', (socket)->
          socket.on 'message', (message)->
            console.log("Got message: " + message)
            ip = socket.handshake.address.address
            url = message;
            io.sockets.emit 'pageview',
              'connections': Object.keys(io.connected).length
              'ip': '***.***.***.' + ip.substring(ip.lastIndexOf('.') + 1)
              'url': url
              'xdomain': socket.handshake.xdomain
              'timestamp': new Date()
          socket.on 'disconnect', ()->
            console.log("Socket disconnected")
            io.sockets.emit 'pageview',
              'connections': Object.keys(io.connected).length

    # console.log server.table()

app.main()