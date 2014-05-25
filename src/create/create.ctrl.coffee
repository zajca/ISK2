'use strict'
module.exports = ["$scope","$state","$rootScope","$translate","projectApi", ($scope,$state,$rootScope,$translate,api) ->
  $scope.init =->
    console.log "init"
  $scope.toogleProjectDropdown=true
  api.fetch().then((res) ->
    $scope.projects = res.data
  )
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