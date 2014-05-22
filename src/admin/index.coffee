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
# require "./../common/slider"
require "./../common/auth"
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
])


module.constant "CONF", require("./admin_dev.json")

module.run (editableOptions) ->
  editableOptions.theme = 'bs3'

module.config ["$urlRouterProvider","$locationProvider","$logProvider","CONF",
  ($urlRouterProvider,$locationProvider,$logProvider,conf)->
    $urlRouterProvider.otherwise "/admin"
    $locationProvider.html5Mode(conf.html5Mode).hashPrefix('!')
    $logProvider.debugEnabled conf.debug
]
module.controller "AdminCtrl", require("./admin.ctrl")
module.config require("./../common/httpInterceptor")

module.run ["titleService",(titleService) ->
  titleService.setSuffix " | Admin"
]