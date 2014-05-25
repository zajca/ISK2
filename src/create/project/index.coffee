'use strict'



m = angular.module("project",[])
m.controller "projectViewCtrl", require("./project.view.ctrl")
m.config require("./router")
m.factory "projectApi", require("./api")
