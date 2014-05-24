"use strict"

m = angular.module("alert", [])
m.directive "alert", ->
  restrict: "EA"
  template: "<div class=\"alert\" ng-class=\"['alert-' + (alert.type || 'warning'), alert.closeable ? 'alert-dismissable' : null]\" role=\"alert\">"+
      "<button ng-show=\"alert.closeable\" type=\"button\" class=\"close\" ng-click=\"close()\">"+
        "<span aria-hidden=\"true\">&times;</span>"+
        "<span class=\"sr-only\">Close</span>"+
      "</button>"+
      "<div>{{alert.msg}}</div>"+
      "<div class=\"ok\" ng-if=\"alert.ok\">OK</div>"+
      "<div class=\"err\" ng-if=\"alert.err\">CHYBA</div>"+
    "</div>"
  replace: true
  scope:false
module.exports = m