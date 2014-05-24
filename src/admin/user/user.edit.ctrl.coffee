'use strict'

module.exports = ["$scope","userApi","$stateParams", ($scope,api,$stateParams) ->
  api.get($stateParams.id).then((res)->
    $scope.user = res.data
  )
  $scope.save = (user)->
    console.log user
    api.update(user)
]