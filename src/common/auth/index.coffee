'use strict'

require "./router"
require "./../../../vendor/angular-local-storage/angular-local-storage"
m = angular.module("auth",["auth.router","LocalStorageModule"])
m.factory "authService", require("./authService")
m.controller "LoginCtrl", require("./loginCtrl")
m.controller "RegisterCtrl", require("./registerCtrl")
m.config require("./authIterceptor")

module.exports = m