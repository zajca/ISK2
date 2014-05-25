'use strict'

module.exports = ["$scope","titleService","PDFViewerService","$stateParams","editorApi","$sce"
  ($scope,titleService,pdf,$stateParams,api,$sce) ->
    titleService.setTitle "EDITOR"
    $scope.viewer = pdf.Instance("viewer")
    pdfUrl = ""
    $scope.fileActual = null
    $scope.trustSrc = (src)->
      $sce.trustAsResourceUrl(src)
    $scope.addFile = (name)->
      $scope.project.tex_files.push({path:name,content:"\\documentclass{article}\n\\usepackage{fontspec}\n\\setmainfont{Palatino Linotype}\n\\begin{document}\n\\end{document}"})
      api.update($scope.project)
    $scope.save =->
      api.update($scope.project)
    $scope.compile=->
      api.compile($scope.project)
    $scope.init = ->
      api.get($stateParams.pid).then (res) ->
        $scope.project = res.data
        $scope.file = $stateParams.file
        for file,key in $scope.project.tex_files
          console.log file.path, $scope.file
          if file.path == $scope.file
            $scope.fileActual = key
        $scope.pdfUrl = "http://pc.zajca.cz:3013/project/#{$stateParams.pid}/output/output.pdf"

    $scope.pageLoaded = (curPage, totalPages) ->
      $scope.currentPage = curPage
      $scope.totalPages = totalPages

    $scope.loadProgress = (loaded, total, state) ->
      console.log "loaded =", loaded, "total =", total, "state =", state
  ]