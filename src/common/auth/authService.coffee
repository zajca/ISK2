module.exports = ["$window", "$location", "$rootScope", "localStorageService","SessionService","FlashService","$translate","$http","CONF","$sanitize"
  ($window, $location, $rootScope, ls, SessionService,FlashService,$translate,$http,CONF,$sanitize) ->
    message = ""
    user =
      email: ""
      password: ""
    ###*
     * sanitize user input
    ###
    get = ->
      email: SessionService.get("email") || ls.get("email") || "anonym"
      token: SessionService.get("token") || ls.get("token") || null
      groups: SessionService.get("goups") || ls.get("goups") || null
      id:SessionService.get("id") || ls.get("id") || 0
    sanitizeCredentials = (credentials) ->
      email: $sanitize(credentials.email)
      password: $sanitize(credentials.password)
    uncacheSession = ->
      SessionService.unset("token")
      SessionService.unset("email")
      SessionService.unset("id")
      SessionService.unset("groups")
      ls.clearAll()
    cacheSession = (data)->
      console.log "cache",data
      SessionService.set("token",data.token)
      ls.set("token",data.token)

      user = angular.fromJson($window.atob(data.token.split(".")[1]))
      console.log user
      SessionService.set("email",user.email)
      SessionService.set("groups",user.groups)
      SessionService.set("id",user.id)

      ls.set("email",user.email)
      ls.set("id",user.id)

    login: (user)->
      n = FlashService.show($translate("FLASH_REQUEST_LOGIN"))
      http = $http.post("#{CONF.apiUrl}login",sanitizeCredentials(user))
      http.then (res)->
        cacheSession(res.data)
        $rootScope.$emit "login"
        $location.path "/"
        FlashService.done(n)
        FlashService.show($translate("FLASH_REQUEST_LOGIN_DONE"))
      ,(res)->
        uncacheSession()
        FlashService.err(id,res.flash)
      http

    register: (user)->
      $translate("FLASH_REQUEST_FOR_REGISTER_USER").then((trans)->
        FlashService.show(trans,"info",(n)->
          http = $http.post("#{CONF.apiUrl}user",user)
          http.then (res)->
            FlashService.done(n)
            FlashService.show($translate("FLASH_REQUEST_FOR_REGISTER_USER_DONE"))
          ,(res)->
            FlashService.err(n,res.flash)
          http
        )
      )
    loginTest:()->
      console.log "login test"
      http = $http.get("#{CONF.apiUrl}login")
      http.then (res)->
        $log.debug "valid login"
      ,(res)->
        $log.debug "invalid login",res
      http
    logout: ->
      uncacheSession()
]