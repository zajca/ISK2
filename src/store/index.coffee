#VENDOR
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
require "./../../vendor/angular-gestures/gestures"
require "./../../vendor/angular-xeditable/dist/js/xeditable"
require "./../../vendor/ngAnimate-animate.css/animate"
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
require "./../common/slider"
#CTRL
require "./storeCTRL"
require "./storeIndex/routes"
require "./user"
require "./settings"
require "./basket"
require "./book"
require "./../common/auth"
#i18n
require "./../i18n"

module = angular.module("store", [
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
  # "SpinnerService"
  "store.ctrl"
  "store.router"
  "match"
  "slider"
  "user"
  "basket"
  "mgcrea.ngStrap"
  "xeditable"
  "settings"
  "ngAnimate-animate.css"
  "book"
  "auth"
  "angular-gestures"
  'btford.socket-io'
])

module.constant "CONF", require("./store_dev.json")

module.run (editableOptions) ->
  editableOptions.theme = 'bs3'

module.config ["$urlRouterProvider","$locationProvider","$logProvider","CONF","$dropdownProvider",
  ($urlRouterProvider,$locationProvider,$logProvider,conf,$dropdownProvider)->
    $urlRouterProvider.otherwise "/"
    $locationProvider.html5Mode(conf.html5Mode).hashPrefix('!')
    $logProvider.debugEnabled conf.debug
    angular.extend $dropdownProvider.defaults,
      animation: "am-flip-x"
      placement: "bottom-left"
]

module.config require("./../common/httpInterceptor")

module.run ["titleService",(titleService) ->
  titleService.setSuffix " | Store"
]

module.factory('socketIO', ["socketFactory",(socketFactory)->
  socketFactory()
])