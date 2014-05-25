require "./../../common/titleService"
require "./../../../vendor/angular-ui-ace/ui-ace"
require "./../../../vendor/ng-pdfviewer/ng-pdfviewer"
require "./../../../vendor/angular-tree-control/angular-tree-control"

m = angular.module("editorElement",["titleService","ui.ace","ngPDFViewer","treeControl"])
m.controller "EditorEditorCtrl", require("./editor")
m.config require("./routes")
m.directive "editor", require("./directive")
m.factory "editorApi", require("./api")

module.exports = m