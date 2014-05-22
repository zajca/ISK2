'use strict'

module.exports = [
  "$stateProvider"
  "$urlRouterProvider"
  "$locationProvider"
  "$logProvider"
  "$provide"
  "$httpProvider"
  (
    $stateProvider
    $urlRouterProvider
    $locationProvider
    $logProvider
    $provide
    $httpProvider
  ) ->
    $urlRouterProvider.otherwise "/editor"
    $locationProvider.html5Mode(true).hashPrefix('!')
    $logProvider.debugEnabled true
    $httpProvider.defaults.headers.common["X-Requested-With"] = "XMLHttpRequest"

    $httpProvider.interceptors.push ["$q","$log","FlashService","SpinnerService",($q,$log,FlashService,SpinnerService) ->
      request: (config) ->
        if config.loading!=false
          SpinnerService.set()
        $log.debug "REQUEST"
        $log.debug config
        #        if config.method == "POST" or config.method == "PUT"
        #          $log.debug csrfService.token
        #          config.headers["X-CSRF-Token"] = csrfService.token
        if config.method == "POST"
          $log.debug "POST"
        config or $q.when(config)
      requestError: (rejection) ->
        $log.debug "REQUEST ERROR"
        $log.debug rejection
        $q.reject rejection
      response: (response) ->
        SpinnerService.unset()
        $log.debug "RESPONSE OK"
        $log.debug response
        if response.config.method == "POST"
          $log.debug "POST"
        response or $q.when(response)
      responseError: (rejection) ->
        SpinnerService.unset()
        $log.debug "RESPONSE ERROR"
        $log.debug rejection
        FlashService.show(rejection,"error")
        $q.reject rejection
    ]
]