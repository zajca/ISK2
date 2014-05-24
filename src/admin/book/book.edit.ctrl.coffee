'use strict'

module.exports = ["$scope","bookApi","$stateParams", ($scope,api,$stateParams) ->
  console.log "ctrl"
  api.get($stateParams.id).then((res)->
    $scope.book = res.data
  )
  $scope.save = (book)->
    api.update(book)
]
