'use strict'

require "./../common/titleService"
require "./bookDirective"

m = angular.module("store.index.ctrl", ["titleService","store.book.directive"])
m.factory("index.api",require "./api")
m.controller "StoreIndexCtrl",
[
  "$scope"
  "titleService"
  "$log"
(
  $scope
  titleService
  $log
) ->
  titleService.setTitle "Obchod výběr knih"

  $scope.init = ->
    $log.debug "init StoreIndexCtrl"
]
module.exports = m