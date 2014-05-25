'use strict'
m = angular.module("book",[])
m.controller "bookViewCtrl", require("./bookViewCtrl")
m.factory "bookApi", require("./api")
m.config require("./router")
module.exports = m