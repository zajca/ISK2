'use strict'

module.exports = ["$scope","bookApi","book",($scope,api,book)->
  console.log "book ctrl"
  $scope.book = book
]