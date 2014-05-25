module.exports = [
  "CONF","FlashService","$translate","$http","$log",
  (CONF,FlashService,$translate,$http,$log)->
    get:(id)->
      console.log "get"
      $translate("FLASH_REQUEST_FOR_PROJECT").then((trans)->
        FlashService.show(trans,"info",(n)->
          http = $http.get("#{CONF.apiUrl}me/project/#{id}")
          http.then (res)->
            $log.debug "fetch api project #{id}",res
            FlashService.done(n)
          ,(res)->
            $log.debug res
            FlashService.err(n,res.flash)
          http
        )
      )
    update: (project)->
      $translate("FLASH_SAVING_PROJECT").then((msg)->
        FlashService.show(msg, "info", (n)->
          http = $http.put("#{CONF.apiUrl}me/project/#{project._id}",project)
          http.then (res)->
            FlashService.done(n)
          ,(res)->
            FlashService.err(n,res.flash)
          http
        )
      )
    compile:(project)->
      request =
        compile:
          options:
            compiler: project.compiler
            timeout: 40
          rootResourcePath: project.rootResourcePath
          resources: project.tex_files
      console.log "requestcompile",request
      $translate("FLASH_COMPILING_PROJECT").then((msg)->
        FlashService.show(msg, "info", (n)->
          http = $http.post("//pc.zajca.cz:3013/project/#{project._id}/compile",request,
            auth:false
          )
          http.then (res)->
            FlashService.done(n)
          ,(res)->
            FlashService.err(n,res.flash)
          http
        )
      )
]