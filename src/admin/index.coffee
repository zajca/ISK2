'use strict'

#VENDOR
#
# auth0 = require "auth0-js"
require "angular"
# require "auth0"
# require "./../../vendor/anguslar/angular"
require "angular-ui-router"
# require "lodash"
# require "./../../vendor/restangular/dist/restangular"
require "./../../vendor/angular-animate/angular-animate"
require "./../../vendor/angular-touch/angular-touch"
require "./../../vendor/angular-cookies/angular-cookies"
require "./../../vendor/angular-sanitize/angular-sanitize"
require "./../../vendor/angular-translate/angular-translate"
require "./../i10n/cs_cz"
require "./../../vendor/angular-carousel/dist/angular-carousel"
require "./../../vendor/angular-strap/dist/angular-strap"
require "./../../vendor/angular-strap/dist/angular-strap.tpl"
require "./../../vendor/angular-socket-io/socket"
require "./../../vendor/angular-xeditable/dist/js/xeditable"
require "./../../vendor/ngAnimate-animate.css/animate"
require "./../../vendor/ng-tags-input/ng-tags-input.js"
require "./../../vendor/ng-flow/dist/ng-flow.js"
require "./../../vendor/ng-table/ng-table.js"
# require "./../../vendor/auth0-angular/src/auth0-angular"

#COMMON
require "./../common/device"
require "./../common/flashService"
require "./../common/preventScrollDirective"
require "./../common/randomHelper"
require "./../common/sessionService"
# require "./../common/spinnerService"
require "./../common/titleService"
require "./../common/bind-html-unsafe"
require "./../common/matchDirective"
# require "./../common/slider"
require "./../common/auth"
require "./../common/alert"
require "./../common/filters"
#CTRL
require "./book"
require "./stats"
require "./user"

# #i18n
require "./../i18n"

module = angular.module("admin", [
  "ui.router"
  "ngAnimate"
  "ngSanitize"
  "ngTouch"
  "bindHtmlUnsafe"
  "device"
  "random"
  "preventScroll"
  "titleService"
  "SessionService"
  "pascalprecht.translate"
  "i18n"
  "FlashService"
  #"SpinnerService"
  "match"
  "mgcrea.ngStrap"
  "xeditable"
  "ngAnimate-animate.css"
  "auth"
  "user"
  "book"
  "stats"
  "ngTagsInput"
  "alert"
  "flow"
  "ngTable"
  'btford.socket-io'
  "filters"
])


module.constant "CONF", require("./admin_dev.json")

module.run (editableOptions) ->
  editableOptions.theme = 'bs3'

module.config ["$urlRouterProvider","$locationProvider","$logProvider","CONF","flowFactoryProvider"
  ($urlRouterProvider,$locationProvider,$logProvider,conf,flowFactoryProvider)->
    $urlRouterProvider.otherwise "/"
    $locationProvider.html5Mode(conf.html5Mode).hashPrefix('!')
    $logProvider.debugEnabled conf.debug
    flowFactoryProvider.defaults =
      target: "#{conf.apiUrl}file"
      permanentErrors: [
        404
        500
        501
      ]
      maxChunkRetries: 1
      chunkRetryInterval: 5000
      simultaneousUploads: 4
      singleFile: true

    flowFactoryProvider.on "fileAdded", (event) ->
      console.log "fileAdded", event
    flowFactoryProvider.on "filesSubmitted", (event) ->
      console.log "filesSubmitted", event
    flowFactoryProvider.on "catchAll", (event) ->
      console.log "catchAll", event

]
module.controller "AdminCtrl", require("./admin.ctrl")
module.config require("./../common/httpInterceptor")

module.run ["titleService",(titleService) ->
  titleService.setSuffix " | Admin"
]

module.factory "admin.api", ["$http","CONF","$log",($http,CONF,$log)->
  login:()->
    console.log "login test"
    http = $http.get("#{CONF.apiUrl}login")
    http.then (res)->
      $log.debug "valid login"
    ,(res)->
      $log.debug "invalid login",res
    http
]

module.factory 'socketIO', ["socketFactory",(socketFactory)->
  socketFactory()
]