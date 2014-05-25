'use strict'
module.exports = ["$scope","$state","$rootScope","$translate", ($scope,$state,$rootScope,$translate) ->
  $scope.init =->
    console.log "init"
  $scope.toogleProjectDropdown=true
  $scope.projects=[
    {
      name:"1"
      _id:"2"
    }
    {
      name:"2"
      _id:"2"
    }
    {
      name:"2"
      _id:"2"
    }
  ]

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