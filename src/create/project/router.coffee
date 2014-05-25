'use strict'

module.exports = ["$stateProvider",($stateProvider) ->
  $stateProvider.state("project",
    url: "/project"
    abstract: true
    views:
      main:
        template: "<ui-view/>"
  ).state("project.list",
    url: "/list"
    controller: "projectListCtrl"
    templateUrl: "/build/partials/create/project/project.list.tpl.html"

  ).state("project.create",
    url: "/create"
    controller: "projectCreateCtrl"
    templateUrl: "/build/partials/create/project/project.create.tpl.html"
  ).state("project.view",
    url: "/detail/:id"
    controller: "projectViewCtrl"
    templateUrl: "/build/partials/create/project/project.view.tpl.html"
  )
]

