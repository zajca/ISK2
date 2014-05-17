m = angular.module("editorApi",[])
m.factory("api",["CONF","FlashService","$translate","$http","$log",(CONF,FlashService,$translate,$http,$log)->
  getProject:(id)->
    n = FlashService.show($translate("FLASH_REQUEST_FOR_PROJECT"))
    http = $http.get("#{CONF.apiUrl}/project/#{id}")
    http.then (res)->
      $log.debug res
      FlashService.done(n)
    ,(res)->
      $log.debug res
      FlashService.err(id,res.flash)
    http

  updateProject:(id)->

  renderProject:(id)->

]
)