'use strict'

m = angular.module( 'FlashService', [])
m.factory "FlashService", [
  "$rootScope",
  "$timeout",
  "$log",
  "$translate",
  ($rootScope,$timeout,$log,$translate) ->
    _counter=0
    register = (flash,type,cb)->
      _counter++
      $log.debug("FlashService._counter",_counter)
      flash.id=_counter
      flash.type = type
      $rootScope.alerts.push(flash)
      cb _counter
    show: (message,type,cb) ->
      $rootScope.alerts = $rootScope.alerts || []
      flash = {}
      if (typeof message is "string")
        flash.msg = message
        register(flash,type,cb)
      else
        $translate('FLASH_UNKNOWN_ERROR').then((trans)->
          flash.msg = trans
          register(flash,type,cb)
        )
    done: (id)->
      $log.debug("FlashService.done",id)
      angular.forEach $rootScope.alerts,(value,key)->
        if value.id==id
          _value = $rootScope.alerts[key]
          _value.type="success"
          _value.closable = true
          _value.ok=true
          console.log "FlashService.value",_value
          $timeout =>
            $rootScope.alerts.splice(key, 1)
          ,4000

    err: (id,msg)->
      $log.debug("FlashService.err",id,msg)
      angular.forEach $rootScope.alerts,(value,key)->
        if value.id==id
          value.type="danger"
          value.closable = true
          value.err=msg.message

    close: (id) ->
      $log.debug("FlashService.close",id)
      angular.forEach $rootScope.alerts,(value,key)->
        if value.id==id
          value.ok=true
]

m.controller "FlashCtrl", ["$scope", "FlashService",($scope, FlashService) ->
  $scope.close = (id) ->
    FlashService.close(id)
]

module.exports = m