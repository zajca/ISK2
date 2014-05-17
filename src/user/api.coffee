'use strict'

m = angular.module("user.api",[])
m.factory "userApi",[
  "CONF",
  "FlashService",
  "$translate",
  "$http",
  "$log",
  (CONF,FlashService,$translate,$http,$log)->
    usernameCheck:(name)->
      $http.get(
        loading:false
        url:"#{CONF.apiUrl}/user/check/username/#{name}"
      )

    registerUser:(user)->
      n = FlashService.show($translate("FLASH_REQUEST_FOR_REGISTER_USER"))
      http = $http.post(
        url:"#{CONF.apiUrl}/user/"
        data: user
      )
      http.then (res)->
        FlashService.done(n)
        FlashService.show($translate("FLASH_REQUEST_FOR_REGISTER_USER_DONE"))
      ,(res)->
        FlashService.err(id,res.flash)
      http

    updateUser:(user)->
      n = FlashService.show($translate("FLASH_REQUEST_FOR_UPDATE_USER"))
      http = $http.put(
        url:"#{CONF.apiUrl}/user/"
        data: user
      )
      http.then (res)->
        FlashService.done(n)
      ,(res)->
        FlashService.err(id,res.flash)
      http
]