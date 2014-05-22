'use strict'

require "./index"

m = angular.module("store.router", ["store.index.ctrl"])

m.config(
  [
    "$stateProvider"
    ($stateProvider) ->
      $stateProvider.state("index",
        url: "/"
        views:
          main:
            controller: "StoreIndexCtrl"
            templateUrl: "/build/partials/store/storeIndex/index.tpl.html"
      )
  ]
)
module.exports = m