'use strict'

module.exports = ["$scope", "$filter","projectApi",($scope, $filter,api)->
  api.fetch().then((res) ->
    $scope.projects = res.data
  )
]