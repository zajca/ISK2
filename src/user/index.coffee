'use strict'

require "./AuthenticationService"
require "./api"
require "./router"

m = angular.module("user",["AuthenticationService","user.api","user.router"])
m.directive "uniqueUsername", require("./checkUserNameDirective")
