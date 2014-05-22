'use strict'

require "./router"

m = angular.module("auth",["auth.router"])
m.factory "authService", require("./authService")
m.controller "LoginCtrl", require("./loginCtrl")
m.config require("./authIterceptor")

module.exports = m