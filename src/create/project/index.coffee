'use strict'

m = angular.module("project",[])
m.controller "projectViewCtrl", require("./project.view.ctrl")
m.controller "projectCreateCtrl", require("./project.create.ctrl")
m.controller "projectListCtrl", require("./project.list.ctrl")
m.config require("./router")
m.factory "projectApi", require("./api")
