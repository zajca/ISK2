'use strict'

m=angular.module("AuthenticationService",[])

m.factory "AuthenticationService", [
  "$http",
  "$sanitize",
  "SessionService",
  "FlashService",
  "$log",
  "$rootScope",
  "$state",
  "CONF"
  ($http, $sanitize, SessionService, FlashService, $log, $rootScope,$state,conf) ->
    
    cacheSession = (response)->
      SessionService.set "authenticated", true
      SessionService.set "authToken", response.authToken
      SessionService.set "role", response.group
      SessionService.set "id", response.id
      $http.defaults.headers.common['X-Authorization'] = response.authToken

    uncacheSession = ->
      SessionService.set "authenticated", false
      SessionService.unset "authToken"
      SessionService.unset  "role"
      SessionService.unset  "id"
      delete $http.defaults.headers.common.Authorization

    loginError = (response) ->
      if response.data.flash is undefined
        return
      else
        FlashService.show(response.data.flash, "error")

    sanitizeCredentials = (credentials) ->
      email: $sanitize(credentials.email)
      password: $sanitize(credentials.password)

    login: (credentials) ->
      n = FlashService.show($translate("FLASH_REQUEST_FOR_LOGIN"))
      http = $http.get("#{CONF.apiUrl}/auth/login")
      http.then (res)->
        cacheSession(res)
        FlashService.done(n)
      ,(res)->
        loginError(res)
        uncacheSession()
        FlashService.err(id,res.flash)
      http

    logout: ->
      n = FlashService.show($translate("FLASH_REQUEST_FOR_LOGOUT"))
      http = $http.get("#{CONF.apiUrl}/auth/logout")
      http.then (res)->
        uncacheSession()
        FlashService.done(n)
      ,(res)->
        uncacheSession()
        FlashService.err(id,res.flash)
      http

    isLoggedIn: ->
      SessionService.get "authenticated"
    
    getRole: ->
      SessionService.get "role"
  ]

module.exports = m