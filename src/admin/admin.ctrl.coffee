module.exports = [
  "$scope"
  "$state"
  "$rootScope"
  "$translate"
  "admin.api"
  (
    $scope
    $state
    $rootScope
    $translate
    API
  ) ->

    $scope.init =->
      API.login()
    $scope.menu=[
      name:"MENU_ADMIN_USERS"
      state: "user.list"
    ,
      name:"MENU_ADMIN_BOOKS"
      state: "book.list"
    ,
      name:"MENU_ADMIN_STATS"
      state: "stats.view"
    ,
      name:"MENU_STORE"
      route: "/"
    ,
      name:"MENU_STORAGE"
      route: "/storage"
    ]

    $rootScope.$on('$stateChangeSuccess',
    (event, toState)->
      angular.forEach($scope.menu, (value)->
        if "#{value.state}" == "#{toState.name}"
          value.active = true
        else
          value.active = false
      )
    )
]