
module.exports = ["$scope","$state","$rootScope",
  ($scope,$state,$rootScope) ->
    $scope.init =->
      # console.log auth
  #    API.csrf()
    $rootScope.$on('$stateChangeSuccess',
    (event, toState)->
      angular.forEach($scope.menu, (value)->
        if value.state == toState.name
          value.active = true
        else
          value.active = false
      )
    )

  ]