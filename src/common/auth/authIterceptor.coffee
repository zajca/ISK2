'use strict'

module.exports = ["$httpProvider",($httpProvider) ->
  $httpProvider.interceptors.push [
    "$q","$log","localStorageService","SessionService",
    ($q,$log,ls,SessionService) ->
      request: (config) ->
        config.headers = config.headers or {}
        token = SessionService.get("token") || ls.get("token") || null
        if config.auth != false
          config.headers.Authorization = "Bearer " + token  if token
        config
      responseError: (response) ->
        $location.path "/login"  if response.status is 401
        $q.reject response
  ]
]