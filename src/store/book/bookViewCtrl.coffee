'use strict'

module.exports = ["$scope","bookApi","book","$basket",($scope,api,book,$basket)->
  $scope.book = book
  $scope.$basket = $basket
  $scope.favourite = (id)->
    api.favourite(id)

  $scope.whish = (id)->
    api.whish(id)

  $scope.add = (book)->
    $basket.add(book,1)
]