'use strict'

require "./router"

m = angular.module("book",["book.router"])
m.controller "bookCtrl", require("./bookCtrl")