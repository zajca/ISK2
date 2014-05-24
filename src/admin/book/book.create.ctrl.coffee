'use strict'

module.exports = ["$scope","bookApi", ($scope,api) ->
  $scope.create = (book)->
    api.create(book)
]