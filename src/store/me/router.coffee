'use strict'

module.exports = ["$stateProvider",($stateProvider) ->
  $stateProvider.state("me",
    url: "/me"
    abstract: true
    views:
      main:
        template: "<ui-view/>"
    ).state("me.profile",
      url: "/profile"
      controller: "meProfileCtrl"
      templateUrl: "/build/partials/store/me/profile.tpl.html"
    ).state("me.edit",
      url: "/edit"
      controller: "meProfileCtrl"
      templateUrl: "/build/partials/store/me/profile.edit.tpl.html"
    )
  ]