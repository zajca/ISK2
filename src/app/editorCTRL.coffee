
module = angular.module("editor.ctrl", [])

module.controller "EditorCtrl", ["$scope","$state","$rootScope",($scope,$state,$rootScope) ->
  $scope.init =->
#    API.csrf()

  $scope.menu=[
    name:"save"
  ,
    name:"compile"
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