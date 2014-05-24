'use strict'

m = angular.module("stats.router", [])

m.config ["$stateProvider",($stateProvider) ->
  $stateProvider.state("stats",
    url: "/stats"
    abstract: true
    views:
      main:
        template: "<ui-view/>"
    ).state("stats.view",
      url: "/view"
      controller: "statsViewCtrl"
      templateUrl: "/build/partials/admin/stats/stats.view.tpl.html"
    )
  ]
module.exports = m
