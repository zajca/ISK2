'use strict'

module.exports = ["$stateProvider",($stateProvider) ->
  "config"
  $stateProvider.state("editor",
    url: "/editor/project/:pid/file/:file"
    # resolve:
    #   project: ($stateParams,editorApi) ->
    #     editorApi.get($stateParams.pid).then (res) ->
    #       res.data
    views:
      main:
        controller: "EditorEditorCtrl"
        templateUrl: "/build/partials/editor/editor/editor.html"
  )
]
