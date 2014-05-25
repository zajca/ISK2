'use strict'

module.exports = [
  "CONF",
  "FlashService",
  "$translate",
  "$http",
  "$log",
  "$state"
  (CONF,FlashService,$translate,$http,$log,$state)->
    getBook:(id)->
      $translate("FLASH_REQUEST_FOR_BOOK").then((trans)->
        FlashService.show(trans,"info",(n)->
          http = $http.get("#{CONF.apiUrl}book/#{id}")
          http.then (res)->
            FlashService.done(n)
          ,(res)->
            FlashService.err(n,res)
          http
        )
      )
    favourite:(id)->
      console.log "favourite"
      FlashService.show("Ukládám do oblíbených","info",(n)->
        http = $http.put("#{CONF.apiUrl}me/favourite/#{id}")
        http.then (res)->
          FlashService.done(n)
        ,(res)->
          FlashService.err(n,res)
        http
      )
    unfavourite:(id)->
      FlashService.show("Mažu z oblíbených","info",(n)->
        http = $http.delete("#{CONF.apiUrl}me/favourite/#{id}")
        http.then (res)->
          FlashService.done(n)
        ,(res)->
          FlashService.err(n,res)
        http
      )
    whish:(id)->
      console.log "favourite"
      FlashService.show("Ukládám do oblíbených","info",(n)->
        http = $http.put("#{CONF.apiUrl}me/whish/#{id}")
        http.then (res)->
          FlashService.done(n)
        ,(res)->
          FlashService.err(n,res)
        http
      )
    unwhish:(id)->
      FlashService.show("Mažu z oblíbených","info",(n)->
        http = $http.delete("#{CONF.apiUrl}me/whish/#{id}")
        http.then (res)->
          FlashService.done(n)
        ,(res)->
          FlashService.err(n,res)
        http
      )
]