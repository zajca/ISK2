'use strict'

m = angular.module("auth.router", [])

m.config(
  ["$stateProvider",($stateProvider) ->
    $stateProvider.state("login",
      url: "/login"
      views:
        main:
          controller: "LoginCtrl"
          templateUrl: "/build/partials/common/auth/login.tpl.html"
    ).state("register",
      url: "/register"
      views:
        main:
          controller: "RegisterCtrl"
          templateUrl: "/build/partials/common/auth/register.tpl.html"
    )
  ]
)
module.exports = m