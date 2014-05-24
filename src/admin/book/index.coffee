'use strict'

m = angular.module("book",[])
m.controller "BookEditCtrl", require("./book.edit.ctrl")
m.controller "BookListCtrl", require("./book.list.ctrl")
m.controller "BookCreateCtrl", require("./book.create.ctrl")
m.factory "bookApi", require("./book.api")
m.config require("./router")
module.exports = m