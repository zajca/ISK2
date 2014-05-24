'use strict'

module.exports = ["$scope","userApi","$stateParams", ($scope,api,$stateParams) ->
  $scope.create = (user)->
    console.log "create"
    api.create(user)
]