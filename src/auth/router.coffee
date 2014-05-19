'use strict'

m = angular.module("auth.router", [])

m.config(
  ["$stateProvider",($stateProvider) ->
    $stateProvider.state("login",
      url: "/login"
      views:
        main:
          controller: "LoginCtrl"
          templateUrl: "/build/partials/auth/login.tpl.html"
    )
  ]
)
module.exports = m