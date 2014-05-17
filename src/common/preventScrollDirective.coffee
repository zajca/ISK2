'use strict'

m = angular.module("preventScroll",[])
m.directive "preventScroll", ["$swipe", ($swipe) ->
  restrict: "AC"
  link: (scope, ele) ->
    $swipe.bind ele,
      start: (pos,e) ->
        e.preventDefault()
]
module.exports = m