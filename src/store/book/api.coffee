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
            FlashService.err(n,res.flash)
          http
        )
      )
]