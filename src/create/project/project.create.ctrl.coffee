'use strict'

module.exports = ["$scope","projectApi","$stateParams", ($scope,api,$stateParams) ->
  $scope.create = (project)->
    console.log "create"
    project.tex_files = []
    project.tex_files.push({path:project.rootResourcePath,content:"\\documentclass{article}\n\\usepackage{fontspec}\n\\setmainfont{Palatino Linotype}\n\\begin{document}\n\\end{document}"})
    console.log "project",project
    api.create(project)
]