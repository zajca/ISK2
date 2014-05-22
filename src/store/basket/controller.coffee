'use strict'


module.exports = ["$scope","$basket",($scope,$basket) ->
  $scope.$basket = $basket

  $scope.update=->
    $scope.items = $basket.get()

  $basket.add({id:1,name:"test",price:10,n:2})
  $basket.add({id:2,name:"test2",price:100,n:3})
]