'use strict'

require "./router"

m = angular.module("stats",["stats.router"])
m.controller "statsViewCtrl", require("./stats.view.ctrl")
