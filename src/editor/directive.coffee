'use strict'

m = angular.module("editor.editor.directive", [])
m.directive "editor",
[
  "$timeout"
(
  $timeout
) ->
  restrict: "E"
  scope:
    input:"="
  replace:true
  template:'<div></div>'
  link: (scope)->
  controller:($scope)->

]
module.exports = m