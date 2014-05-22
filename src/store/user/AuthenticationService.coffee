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
    ###*
     * cache user seassion
    ###
    cacheSession = (response)->
      SessionService.set "authenticated", true
      SessionService.set "authToken", response.authToken
      SessionService.set "group", response.groups
      SessionService.set "id", response.id
      $http.defaults.headers.common['X-Authorization'] = response.authToken
    ###*
     * uncache user session
    ###
    uncacheSession = ->
      SessionService.set "authenticated", false
      SessionService.unset "authToken"
      SessionService.unset  "groups"
      SessionService.unset  "id"
      delete $http.defaults.headers.common.Authorization
    ###*
     * show login error
    ###
    loginError = (response) ->
      if response.data.flash is undefined
        return
      else
        FlashService.show(response.data.flash, "error")
    ###*
     * sanitize user input
    ###
    sanitizeCredentials = (credentials) ->
      email: $sanitize(credentials.email)
      password: $sanitize(credentials.password)
    ###*
     * api login
    ###
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
    ###*
     * api logout
    ###
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

    getGroups: ->
      SessionService.get "groups"
  ]

module.exports = m