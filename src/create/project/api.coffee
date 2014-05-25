'use strict'

module.exports = ["$window", "$location", "$rootScope", "SessionService","FlashService","$translate","$http","CONF","$log"
  ($window, $location, $rootScope, SessionService,FlashService,$translate,$http,CONF,$log) ->
    create: (project)->
      console.log "API"
      $translate("FLASH_CREATING_PROJECT").then((msg)->
        FlashService.show(msg, "info", (n)->
          http = $http.post("#{CONF.apiUrl}/me/project",project)
          http.then (res)->
            FlashService.done(n)
          ,(res)->
            FlashService.err(n,res.flash)
          http
        )
      )
    update: (project)->
      $translate("FLASH_SAVING_PROJECT").then((msg)->
        FlashService.show(msg, "info", (n)->
          http = $http.put("#{CONF.apiUrl}/me/project/#{project._id}",project)
          http.then (res)->
            FlashService.done(n)
          ,(res)->
            FlashService.err(n,res.flash)
          http
        )
      )

    fetch:()->
      console.log "fetch"
      $translate("FLASH_REQUEST_FOR_PROJECT").then((trans)->
        FlashService.show(trans,"info",(n)->
          http = $http.get("#{CONF.apiUrl}/me/project")
          http.then (res)->
            $log.debug "fetch api project all",res
            FlashService.done(n)
          ,(res)->
            $log.debug res
            FlashService.err(n,res.flash)
          http
        )
      )

    get:(id)->
      console.log "get"
      $translate("FLASH_REQUEST_FOR_PROJECT").then((trans)->
        FlashService.show(trans,"info",(n)->
          http = $http.get("#{CONF.apiUrl}/me/project/#{id}")
          http.then (res)->
            $log.debug "fetch api project #{id}",res
            FlashService.done(n)
          ,(res)->
            $log.debug res
            FlashService.err(n,res.flash)
          http
        )
      )
]