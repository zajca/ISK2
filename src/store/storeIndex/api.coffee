module.exports = [
  "$http","CONF","$log","FlashService","$translate",
  ($http,CONF,$log,FlashService,$translate)->

    fetch:(tag)->
      console.log "fetch"
      $translate("FLASH_REQUEST_FOR_BOOKS").then((trans)->
        FlashService.show(trans,"info",(n)->
          console.log "trans"
          if tag?
            http = $http.get("#{CONF.apiUrl}book/find/#{tag}")
          else
            http = $http.get("#{CONF.apiUrl}book")

          http.then (res)->
            $log.debug "fetch api book",res
            FlashService.done(n)
          ,(res)->
            $log.debug res
            FlashService.err(n,res.flash)
          http
        )
      )

    query:(params)->
      $translate("FLASH_REQUEST_FOR_BOOKS").then((trans)->
        FlashService.show(trans,"info",(n)->
          params = params||{}
          http = $http.get("#{CONF.apiUrl}book",params)
          http.then (res)->
            $log.debug res
            FlashService.done(n)
          ,(res)->
            $log.debug res
            FlashService.err(n,res.flash)
          http
        )
      )
]