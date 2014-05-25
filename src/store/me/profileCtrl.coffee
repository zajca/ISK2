
module.exports =[
  "$scope","meApi","$state",
  ($scope,api,$state) ->
    $scope.user = {}

    api.getMe().then((res)->
      $scope.user =  res.data
    )
    $scope.updateMe = (data)->
      api.updateMe(data).then (res)->
        $scope.user = res.data
        $state.go("me.profile")
]