'use strict'

module.exports = ["$stateProvider",($stateProvider) ->
  $stateProvider.state("project",
    url: "/project"
    abstract: true
    views:
      main:
        template: "<ui-view/>"
    ).state("project.view",
      url: "/:id"
      controller: "projectViewCtrl"
      templateUrl: "/build/partials/create/project/project.view.tpl.html"
      resolve:
        project:($stateParams,projectApi)->
          projectApi.get($stateParams.id).then((res)->
            res.data
          )
    )
  ]

