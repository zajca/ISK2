module.exports = ["$window", "$location", "$rootScope", "localStorageService","SessionService","FlashService","$translate","$http","CONF","$sanitize"
  ($window, $location, $rootScope, ls, SessionService,FlashService,$translate,$http,CONF,$sanitize) ->
    message = ""
    user =
      email: ""
      password: ""
    ###*
     * sanitize user input
    ###
    sanitizeCredentials = (credentials) ->
      email: $sanitize(credentials.email)
      password: $sanitize(credentials.password)
    uncacheSession = ->
      SessionService.unset("token")
      SessionService.unset("email")
      SessionService.unset("id")
      ls.clearAll()
    cacheSession = (data)->
      console.log "cache",data
      SessionService.set("token",data.token)
      ls.set("token",data.token)

      user = angular.fromJson($window.atob(data.token.split(".")[1]))
      console.log user
      SessionService.set("email",user.email)
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

    logout: ->
      n = FlashService.show($translate("FLASH_REQUEST_FOR_LOGOUT"))
      http = $http.get("#{CONF.apiUrl}logout")
      http.then (res)->
        uncacheSession()
        FlashService.done(n)
      ,(res)->
        uncacheSession()
        FlashService.err(id,res.flash)
      http
]