'use strict'

module.exports = ["$scope","authService",($scope,auth)->
  $scope.login = (user)->
    auth.login(user)

]