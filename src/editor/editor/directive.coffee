'use strict'

module.exports = ["$timeout",
  ($timeout) ->
    restrict: "E"
    scope:
      input:"="
    replace:true
    template:'<div></div>'
    link: (scope)->
    controller:($scope)->

]