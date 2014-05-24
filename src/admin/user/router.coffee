'use strict'

module.exports = ["$stateProvider",($stateProvider) ->
  $stateProvider.state("user",
    url: "/user"
    abstract: true
    views:
      main:
        template: "<ui-view/>"
    ).state("user.list",
      url: "/list"
      controller: "userListCtrl"
      templateUrl: "/build/partials/admin/user/user.list.tpl.html"
      resolve:
        users: (userApi) ->
          userApi.fetch()
    ).state("user.create",
      url: "/create"
      controller: "userCreateCtrl"
      templateUrl: "/build/partials/admin/user/user.create.tpl.html"
    ).state("user.edit",
      url: "/edit/:id"
      controller: "userEditCtrl"
      templateUrl: "/build/partials/admin/user/user.edit.tpl.html"
    )
  ]
