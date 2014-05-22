'use strict'

m = angular.module("store.book.directive", [])
m.directive "book",
[
  "$timeout"
(
  $timeout
) ->
  restrict: "E"
  scope:false
  replace:true
  template:'<div class="book" ng-mouseover="hover = true;" ng-mouseleave="hover = false;"><img src="http://placehold.it/125x200" /><div class="hover" ng-if="hover">{{book.name}}</div><div>'
  link: (scope)->
  controller:($scope)->
]
module.exports = m