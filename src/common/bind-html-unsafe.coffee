"use strict"

m = angular.module("bindHtmlUnsafe", [])

m.directive "bindHtmlUnsafe", ["$compile",($compile) ->
  ["$scope", "$element", "$attrs",($scope, $element, $attrs) ->
    compile = (newHTML) -> # Create re-useable compile function
      newHTML = $compile(newHTML)($scope) # Compile html
      $element.html("").append newHTML # Clear and append it

    htmlName = $attrs.bindHtmlUnsafe # Get the name of the variable
    # Where the HTML is stored
    $scope.$watch htmlName, (newHTML) -> # Watch for changes to
      # the HTML
      return  unless newHTML
      compile newHTML # Compile it
  ]
]
module.exports = m