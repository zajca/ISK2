'use strict'

require "./../common/titleService"
require "./../../vendor/angular-ui-ace/ui-ace"
require "./../../vendor/ng-pdfviewer/ng-pdfviewer"
# require "./../../vendor/angular-ui-layout/ui-layout"
require "./../../vendor/angular-tree-control/angular-tree-control"

m = angular.module("editor.editor.ctrl", ["titleService","ui.ace","ngPDFViewer","treeControl"])
m.controller "EditorEditorCtrl",
  [
    "$scope"
    "titleService"
    "PDFViewerService"
  (
    $scope
    titleService
    pdf
  ) ->
    titleService.setTitle "EDITOR"

    $scope.init = ->

#      $scope.pdfUrl = '/pdfjs/examples/helloworld/helloworld.pdf'
      $scope.pdfUrl = '/ng-pdfviewer/demo/test.pdf'
      $scope.viewer = pdf.Instance("viewer")

    $scope.pageLoaded = (curPage, totalPages) ->
      $scope.currentPage = curPage
      $scope.totalPages = totalPages
      return

    $scope.loadProgress = (loaded, total, state) ->
      console.log "loaded =", loaded, "total =", total, "state =", state
      return

    getNum = ->
      num++
    createSubTree = (level) ->
      if level > 0
        [
          {
            label: "Node " + getNum()
            id: "id"
            children: createSubTree(level - 1)
          }
          {
            label: "Node " + getNum()
            id: "id"
            children: createSubTree(level - 1)
          }
          {
            label: "Node " + getNum()
            id: "id"
            children: createSubTree(level - 1)
          }
          {
            label: "Node " + getNum()
            id: "id"
            children: createSubTree(level - 1)
          }
        ]
      else
        []
    num = 1
    $scope.treedata = createSubTree(3)
    $scope.showSelected = (sel) ->
      $scope.selected = sel.label
      return

    $scope.addRoot = ->
      $scope.treedata.push
        label: "New Node " + getNum()
        id: "id"
        children: []

      return

    $scope.addChild = ->
      $scope.treedata[0].children.push
        label: "New Node " + getNum()
        id: "id"
        children: []
      return
  ]

module.exports = m  