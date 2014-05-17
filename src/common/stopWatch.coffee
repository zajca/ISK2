'use strict'

# update Model
m = angular.module("stopwatch", [])
m.directive "stopWatch", ["$timeout",($timeout) ->
  restrict: "E"
  transclude: true
  scope:
    control: '='
    minutes: '='
    seconds: '='
  controller: ($rootScope, $scope, $element, $log) ->
    timeoutId = undefined
    timer = ->
      timeoutId = $timeout(->
        updateTime()
        timer()
      , 1000)
    updateTime = ->
      $scope.seconds++
      if $scope.seconds is 60
        $scope.seconds = 0
        $scope.minutes++

    $scope.seconds = 0
    $scope.minutes = 0
    $scope.running = false

    stop = ->
      $log.debug("watch stop")
      $timeout.cancel(timeoutId)
      $scope.running = false

    clear = ->
      $log.debug("watch clear")
      $scope.seconds = 0
      $scope.minutes = 0

    start = ->
      $log.debug("watch start")
      clear()
      timer()
      $scope.running = true

    $scope.$watch("control",(newVal)->
      switch newVal
        when 1 then start()
        when 2 then stop()
        when 3 then clear()
    )

  template: "<div class=\"stopWatch\">" +
  "<div>{{minutes|numberpad:2}}:{{seconds|numberpad:2}}</div>" +
  "</div>"
  replace: true
]
m.filter "numberpad", ->
  (input, places) ->
    out = ""
    if places
      placesLength = parseInt(places, 10)
      inputLength = input.toString().length
      i = 0

      while i < (placesLength - inputLength)
        out = "0" + out
        i++
      out = out + input
    out
    
module.exports = m