'use strict'

module.exports = [
  "CONF",
  "FlashService",
  "$translate",
  "$http",
  "$log",
  "$state"
  (CONF,FlashService,$translate,$http,$log,$state)->
    usernameCheck:(name)->
      $http.get(
        loading:false
        url:"#{CONF.apiUrl}/user/check/username/#{name}"
      )

    updateMe:(user)->
      $translate("FLASH_REQUEST_FOR_UPDATE_USER").then((trans)->
        FlashService.show(trans,"info",(n)->
          http = $http.put("#{CONF.apiUrl}me",user)
          http.then (res)->
            FlashService.done(n)
          ,(res)->
            FlashService.err(n,res.flash)
          http
          )
        )
    getMe:->
      $translate("FLASH_REQUEST_FOR_USER").then((trans)->
        FlashService.show(trans,"info",(n)->
          http = $http.get("#{CONF.apiUrl}me")
          http.then (res)->
            FlashService.done(n)
          ,(res)->
            FlashService.err(n,res.flash)
          http
        )
      )
]