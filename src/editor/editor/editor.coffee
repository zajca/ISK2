'use strict'

module.exports = ["$scope","titleService","PDFViewerService","$stateParams","editorApi","$sce"
  ($scope,titleService,PDFViewerService,$stateParams,api,$sce) ->
    titleService.setTitle "EDITOR"
    $scope.viewer = PDFViewerService.Instance("viewer")
    $scope.pdfUrl = ""
    $scope.fileActual = null
    $scope.scroll = 0;
    $scope.addFile = (name)->
      $scope.project.tex_files.push({path:name,content:"\\documentclass{article}\n\\usepackage{fontspec}\n\\setmainfont{Palatino Linotype}\n\\begin{document}\n\\end{document}"})
      api.update($scope.project)
    $scope.save =->
      api.update($scope.project)
    $scope.compile=->
      api.compile($scope.project).then((res)->
        $scope.pdfUrl = $sce.trustAsResourceUrl("http://pc.zajca.cz:3013/project/#{$stateParams.pid}/output/output.pdf")
      )
    $scope.init = ->
      api.get($stateParams.pid).then (res) ->
        $scope.project = res.data
        $scope.file = $stateParams.file
        for file,key in $scope.project.tex_files
          if file.path == $scope.file
            $scope.fileActual = key
        $scope.pdfUrl = $sce.trustAsResourceUrl("http://pc.zajca.cz:3013/project/#{$stateParams.pid}/output/output.pdf")

    $scope.pageLoaded = (curPage, totalPages) ->
      console.log "loaded",curPage,totalPages
      $scope.currentPage = curPage
      $scope.totalPages = totalPages

    $scope.loadProgress = (loaded, total, state) ->
      console.log "loaded =", loaded, "total =", total, "state =", state
  ]