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
User = db.user
Book = db.book

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

      server.start(->
        io = SocketIO.listen(server.listener)
      )

    # console.log server.table()

app.main()