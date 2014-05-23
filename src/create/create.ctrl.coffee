module.exports = [
  "$scope"
  "$state"
  "$rootScope"
  "$translate"
  (
    $scope
    $state
    $rootScope
    $translate
  ) ->

    $scope.init =->
  #    API.csrf()
    $scope.menu=[
      name:"MENU_ADMIN_USERS"
      state: "user.list"
    ,
      name:"MENU_ADMIN_BOOKS"
      state: "book.list"
    ,
      name:"MENU_ADMIN_STATS"
      state: "stats.list"
    ,
      name:"MENU_STORE"
      route: "/"
    ,
      name:"MENU_STORAGE"
      route: "/storage"
    ,
      name:"MENU_LOGOUT"
      route: undefined
      # special: "login"
      icon: "fa-sign-in"
      class: "pull-right"
      route: "/logout"
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