###*
 * LOAD MODULES
###
Hapi    = require("hapi")


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
        path: __dirname + "/build/partials"
        path: __dirname + "/views"
        compileOptions:
          pretty: true

    server = new Hapi.Server(config.app.port, options)

    ###*
     * Nastaveni routeru
    ###
    require("./config").router(server)
    require("./routes").load(server)
    views.router(server)

    server.start()

app.main()