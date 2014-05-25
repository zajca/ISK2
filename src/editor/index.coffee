#VENDOR
require "angular"
require "angular-ui-router"
require "./../../vendor/angular-animate/angular-animate"
require "./../../vendor/angular-touch/angular-touch"
require "./../../vendor/angular-translate/angular-translate"
require "./../../vendor/angular-socket-io/socket"
require "./../i10n/cs_cz"
#COMMON
require "./../common/device"
require "./../common/flashService"
require "./../common/preventScrollDirective"
require "./../common/randomHelper"
require "./../common/sessionService"
require "./../common/titleService"
require "./../common/bind-html-unsafe"
require "./../common/alert"
require "./../common/auth"
#CTRL
require "./editor"

#require "../user"
#i18n
require "./../i18n/index"

module = angular.module("editor", [
  "ui.router"
  "ngAnimate"
  "ngTouch"
  "bindHtmlUnsafe"
  "device"
  "random"
  "preventScroll"
  "titleService"
  "SessionService"
  "pascalprecht.translate"
  "i18n"
  "auth"
  "FlashService"
  "editorElement"
  "alert"
  'btford.socket-io'
])

module.constant "CONF", require("./editor_dev.json")

module.config ["$urlRouterProvider","$locationProvider","$logProvider",($urlRouterProvider,$locationProvider,$logProvider)->
  conf = require("./editor_dev.json")
  console.log conf
  $urlRouterProvider.otherwise "/"
  $locationProvider.html5Mode(conf.html5Mode).hashPrefix('!')
  $logProvider.debugEnabled conf.debug
]

module.config require("./../common/httpInterceptor")

module.run ["titleService",(titleService) ->
  titleService.setSuffix " | Editor"
]
module.controller "EditorCtrl", require("./editor.ctrl")

