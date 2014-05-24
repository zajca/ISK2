'use strict'

m = angular.module("user",[])
m.config require("./router")

m.controller "userEditCtrl", require("./user.edit.ctrl")
m.controller "userListCtrl", require("./user.list.ctrl")
m.controller "userCreateCtrl", require("./user.create.ctrl")
m.factory "userApi", require("./user.api")