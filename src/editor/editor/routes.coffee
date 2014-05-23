'use strict'

require "./editor"

m = angular.module("editor.editor", ["editor.editor.ctrl"])

m.config(
  ["$stateProvider",($stateProvider) ->
#    $stateProvider.state("index",
#      url: "/directory"
#      abstract: true
#      views:
#        main:
#          templateUrl: "directory/directory.tpl.html"

    $stateProvider.state("editor",
      url: "/editor"
      views:
        main:
          controller: "EditorEditorCtrl"
          templateUrl: "/build/partials/editor/editor/editor.html"
    )
  ]
)
module.exports = m