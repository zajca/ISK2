'use strict'

m = angular.module("me",[])
m.directive "uniqueUsername", require("./checkUserNameDirective")
m.config require "./router"
m.factory "meApi",require "./api"
m.controller "meProfileCtrl", require("./profileCtrl")