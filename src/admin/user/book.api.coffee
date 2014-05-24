'use strict'

module.exports = ["$window", "$location", "$rootScope", "SessionService","FlashService","$translate","$http","CONF","$log"
  ($window, $location, $rootScope, SessionService,FlashService,$translate,$http,CONF,$log) ->
    create: (user)->
      $translate("FLASH_CREATING_USER").then((msg)->
        FlashService.show(msg, "info", (n)->
          http = $http.post("#{CONF.apiUrl}user",user)
          http.then (res)->
            FlashService.done(n)
          ,(res)->
            FlashService.err(n,res.flash)
          http
        )
      )
    update: (user)->
      $translate("FLASH_SAVING_USER").then((msg)->
        FlashService.show(msg, "info", (n)->
          http = $http.put("#{CONF.apiUrl}user/#{user._id}",user)
          http.then (res)->
            FlashService.done(n)
          ,(res)->
            FlashService.err(n,res.flash)
          http
        )
      )

    fetch:()->
      console.log "fetch"
      $translate("FLASH_REQUEST_FOR_BOOKS").then((trans)->
        FlashService.show(trans,"info",(n)->
          http = $http.get("#{CONF.apiUrl}user")
          http.then (res)->
            $log.debug "fetch api user all",res
            FlashService.done(n)
          ,(res)->
            $log.debug res
            FlashService.err(n,res.flash)
          http
        )
      )

    get:(id)->
      console.log "get"
      $translate("FLASH_REQUEST_FOR_BOOKS").then((trans)->
        FlashService.show(trans,"info",(n)->
          http = $http.get("#{CONF.apiUrl}user/#{id}/all")
          http.then (res)->
            $log.debug "fetch api user #{id}",res
            FlashService.done(n)
          ,(res)->
            $log.debug res
            FlashService.err(n,res.flash)
          http
        )
      )
    remove:(id)->
      console.log "remove user"
      $translate("FLASH_REQUEST_FOR_DELETE_BOOK").then((trans)->
        FlashService.show(trans,"danger",(n)->
          http = $http.delete("#{CONF.apiUrl}user/#{id}")
          http.then (res)->
            $log.debug "delete user #{id}",res
            FlashService.done(n)
          ,(res)->
            $log.debug res
            FlashService.err(n,res.flash)
          http
        )
      )

]