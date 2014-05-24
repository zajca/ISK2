'use strict'

module.exports = ["$window", "$location", "$rootScope", "SessionService","FlashService","$translate","$http","CONF","$log"
  ($window, $location, $rootScope, SessionService,FlashService,$translate,$http,CONF,$log) ->
    create: (book)->
      $translate("FLASH_CREATING_BOOK").then((msg)->
        FlashService.show(msg, "info", (n)->
          http = $http.post("#{CONF.apiUrl}book",book)
          http.then (res)->
            FlashService.done(n)
          ,(res)->
            FlashService.err(n,res.flash)
          http
        )
      )
    update: (book)->
      $translate("FLASH_SAVING_BOOK").then((msg)->
        FlashService.show(msg, "info", (n)->
          http = $http.put("#{CONF.apiUrl}book/#{book._id}",book)
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
          http = $http.get("#{CONF.apiUrl}book")
          http.then (res)->
            $log.debug "fetch api book all",res
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
          http = $http.get("#{CONF.apiUrl}book/#{id}/all")
          http.then (res)->
            $log.debug "fetch api book #{id}",res
            FlashService.done(n)
          ,(res)->
            $log.debug res
            FlashService.err(n,res.flash)
          http
        )
      )
    remove:(id)->
      console.log "remove book"
      $translate("FLASH_REQUEST_FOR_DELETE_BOOK").then((trans)->
        FlashService.show(trans,"danger",(n)->
          http = $http.delete("#{CONF.apiUrl}book/#{id}")
          http.then (res)->
            $log.debug "delete book #{id}",res
            FlashService.done(n)
          ,(res)->
            $log.debug res
            FlashService.err(n,res.flash)
          http
        )
      )

]