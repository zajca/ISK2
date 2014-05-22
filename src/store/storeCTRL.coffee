m = angular.module("store.ctrl", [])

m.controller "StoreCtrl", [
  "$scope"
  "$state"
  "$rootScope"
  "$translate"
  "$basket"
  (
    $scope
    $state
    $rootScope
    $translate
    $basket
  ) ->
    
    updateBasket = ->
      $scope.basket  = if $basket.sum().n > 1 then true else false 

    $scope.$on('BASKET_UPDATE',updateBasket)

    $scope.init =->
  #    API.csrf()
    $scope.menu=[
      name:"MENU_BOOKS"
      state: "index"
    ,
      name:"MENU_ADMINISTRATION"
      route: "/admin"
    ,
      name:"MENU_CREATE"
      route: "/create"
    ,
      name:"MENU_FINANCE"
      route: "/finance"
    ,
      name:"MENU_STORAGE"
      route: "/storage"
    ,
      name:"MENU_REGISTER"
      route: undefined
      special: "register"
      class: "pull-right"
      template: "/build/partials/store/user/register.tpl.html"
    # ,
    #   name:"MENU_LOGIN"
    #   route: undefined
    #   # special: "login"  
    #   icon: "fa-sign-in"
    #   class: "pull-right"
    #   template: "/build/partials/store/user/login.tpl.html"
    ]

    $scope.books=[
      {
        name:"book"
        id: "1"
        img: "test"
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
module.exports = m