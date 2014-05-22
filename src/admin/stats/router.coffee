'use strict'

m = angular.module("stats.router", [])

m.config(
  ["$stateProvider",($stateProvider) ->
    $stateProvider.state("stats",
      url: "/stats"
      views:
        main:
          controller: "StatsCtrl"
          templateUrl: "/build/partials/admin/stats/stats.view.tpl.html"
    )
  ]
)
module.exports = m
