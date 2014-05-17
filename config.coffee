path = require("path")
# passport = require("passport")
authConfig = require('./middleware/auth/config')
mongoose = require('mongoose')

module.exports =
  setUp: (app,config)->

    #AUTH
    authConfig.set
      'systemCookieSalt': '5GiNxOayeGDEIImNyzsEDspRJLhaIAZsG9vMqnjlXnTgX2ELzk',
      'systemSignedCookieSalt': 'JuOkxMXBquIDQMrojSBz4vGq0EsGLhOQXK78VIri5tPkHH8W3J7Y8t',
      'systemStorageSalt': 'Kjl6LVkXE2XTw3TE84lP5sebXkNPwAOb6Y9ess7ua2MQim6Wv1',
      'systemPasswordSalt': 'nT.31_F!8z.Q[ of^$PEmWSddddY&cG%n#L|]}',
      'cookieIterations': 1000,
      'passwordIterations': 1000,
      'cookieKeylen': 64,
      'passwordKeylen': 64,
      'randomBytesSize': 64,
      'tokenName': 'authToken',
      'httpHeader': 'X-Authorization',
      'maxAge': 3 * 24 * 60 * 60 #3dny

    authConfig.setModel require('./database/schema/user')

  getConfig: (env)->
    if env is "dev"
      mongoose.set('debug', true)
      config=require "./config/appDev"
      console.log "running in development environment"
    else if env is "test"
      config=require "./config/appTest"
      console.log "running in testing environment"
    else
      config=require "./config/appProd"
      console.log "running in production environment"
    config

  router: (server)->
    server.route(
      method: 'GET'
      path: '/vendor/{path*}'
      handler:
        directory:
          path: './vendor'
          listing: false
          index: true
    )
    server.route(
      method: 'GET'
      path: '/build/{path*}'
      handler:
        directory:
          path: './build'
          listing: false
          index: true
    )