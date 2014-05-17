'use strict'

module.exports = [
  "$http"
  "userApi"
  ($http,api) ->
    return (
      require: "ngModel"
      link: (scope, elem, attrs, ctrl) ->
        scope.busy = false
        scope.$watch attrs.ngModel, (value) ->
          
          # hide old error messages
          ctrl.$setValidity "isTaken", true
          ctrl.$setValidity "invalidChars", true
          
          # don't send undefined to the server during dirty check
          # empty username is caught by required directive
          return  unless value
          
          # show spinner
          scope.busy = true
          
          # send request to server
          
          # everything is fine -> do nothing
          api.usernameCheck().success((data) ->
            scope.busy = false
          ).error (data) ->
            
            # display new error message
            if data.isTaken
              ctrl.$setValidity "isTaken", false
            else ctrl.$setValidity "invalidChars", false  if data.invalidChars
            scope.busy = false
    )
]