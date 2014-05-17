'use strict'

m = angular.module( 'SessionService', [])
m.factory("SessionService", ->
  get: (key) ->
    sessionStorage.getItem key

  set: (key, val) ->
    sessionStorage.setItem key, val

  unset: (key) ->
    sessionStorage.removeItem key
)
module.exports = m