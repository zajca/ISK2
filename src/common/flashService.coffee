'use strict'

m = angular.module( 'FlashService', [])
m.factory "FlashService", [
  "$rootScope",
  "$timeout",
  "$log",
  "$translate",
  ($rootScope,$timeout,$log,$translate) ->
    counter=0
    show: (message,type) ->
      $rootScope.alerts = $rootScope.alerts || []
      flash = {}
      if (typeof message is "string")
        flash.msg = message
      else
        flash.msg = $translate('FLASH_UNKNOWN_ERROR')

      $log.debug(counter)
      counter++
      flash.id=counter
      flash.type = type
      $rootScope.alerts.push(flash)
      counter

    done: (id)->
      angular.forEach $rootScope.alerts,(value,key)->
        if value.id==id
          value.ok=true
          $timeout($rootScope.alerts.splice(key, 1),2000)

    err: (id,msg)->
      angular.forEach $rootScope.alerts,(value,key)->
        if value.id==id
          value.ok=true
          value.err=msg

    close: (id) ->
      angular.forEach $rootScope.alerts,(value,key)->
        if value.id==id
          value.ok=true
]

m.controller "FlashCtrl", ["$scope", "FlashService",($scope, FlashService) ->
  $scope.close = (id) ->
    FlashService.close(id)
]

module.exports = m