'use strict'

module.exports = [
  "$scope",
  "authService",
  ($scope,auth) ->
    $scope.save = (user)->
      console.log user
      auth.register(user)
]