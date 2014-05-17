'use strict'

m = angular.module( 'device', [])

m.factory("device", ["$window",($window) ->
  keyframeprefix=""
  animationstring="animation"
  animation = false
  ###
  Modernizr touch detection
  https://github.com/Modernizr/Modernizr/blob/master/feature-detects/touchevents.js
  ###
  isTouch: ->
    if ("ontouchstart" of $window) or $window.DocumentTouch and $document instanceof DocumentTouch
      true
    else
      false
  ###
  detect and set animationframe
  ###
  setAnimationFrame: ->
    $window.requestAnimFrame = (->
      $window.requestAnimationFrame or $window.webkitRequestAnimationFrame or $window.mozRequestAnimationFrame or (callback) ->
        $window.setTimeout callback, 1000 / 60
        return
    )()
  ###
  Detect and set animation
  ###

  getKeyframeprefix:->
    keyframeprefix

  getAnimationstring:->
    animationstring

  getAnimation:->
    animation

  detectAnimation:->
    domPrefixes = "Webkit Moz O ms Khtml".split(" ")
    elm = document.getElementById("ng-app")
    pfx = ""
    animation = true  if elm.style.animationName
    if animation is false
      i = 0

      while i < domPrefixes.length
        if elm.style[domPrefixes[i] + "AnimationName"] isnt undefined
          pfx = domPrefixes[i]
          animationstring = pfx + "Animation"
          keyframeprefix ="-" + pfx.toLowerCase() + "-"
          animation = true
          break
        i++
])
module.exports = m