'use strict'

module.exports = ["$httpProvider",($httpProvider) ->
  $httpProvider.interceptors.push ["$q","$log","SessionService",($q,$log,SessionService) ->
    request: (config) ->
      config.headers = config.headers or {}
      config.headers.Authorization = "Bearer " + SessionService.get("token")  if SessionService.get("token")
      config
    responseError: (response) ->
      $location.path "/login"  if response.status is 401
      $q.reject response
  ]
]