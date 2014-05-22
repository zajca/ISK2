'use strict'

m = angular.module("book",[])
m.controller "bookEditCtrl", require("./book.edit.ctrl")
m.controller "bookListCtrl", require("./book.list.ctrl")
m.controller "bookCreateCtrl", require("./book.create.ctrl")
m.config require("./router")
module.exports = m