'use strict'

module.exports = [
  "$scope",
  "userAPI",
  ($scope,api) ->
    $scope.user = {}
    $scope.save = api.
]