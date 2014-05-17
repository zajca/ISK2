'use strict'

m = angular.module( 'SpinnerService', [])
m.factory("SpinnerService",["$rootScope",($rootScope) ->
  set:->
    r = sessionStorage.getItem "request"
    if r?
      sessionStorage.setItem "request", 0
    sessionStorage.setItem "request", r++
    $rootScope.$broadcast("LOADING")

  unset:->
    r = sessionStorage.getItem "request"
    sessionStorage.setItem "request", r--
    if r <= 1
      sessionStorage.setItem "request", 0
      $rootScope.$broadcast("LOADING_END")
])
m.directive("spinner",->
  restrict: "E"
  replace:true
  scope:{}
  link: (scope) ->
    scope.$on("LOADING",->
      scope.loading=true
    )
    scope.$on("LOADING_END",->
      scope.loading=false
    )
    return
  template:'<div><div ng-if="loading" class="dim"></div>
  <div ng-if="loading" class="spinner-wrapper">
  <div class="spinner">
  <div class="bounce1"></div>
  <div class="bounce2"></div>
  <div class="bounce3"></div>
  </div></div></div>'
)
module.exports = m