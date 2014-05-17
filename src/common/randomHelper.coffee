'use strict'

m= angular.module( 'random', [])
m.factory "random", ->
  randomNumber:->
    Math.floor(Math.random())
  randomNumberBetween:(min,max)->
    Math.random() * (max - min) + min
  randomFromArray:(array)->
    array[Math.floor(Math.random() * array.length)]
  randomNumberFromArray:(array)->
    Math.floor(Math.random() * array.length)
  randomIntBetween:(from,to)->
    Math.floor(Math.random() * to) + from
  randomNumberFromZero:(to)->
    Math.floor(Math.random() * to)
  randomTF:->
    Math.random() < 0.5 ? true : false
  randomizeArray:(arr)->
    j = undefined
    x = undefined
    i = arr.length

    while i
      j = parseInt(Math.random() * i)
      x = arr[--i]
      arr[i] = arr[j]
      arr[j] = x
    arr
  toFixed:(value, precision) ->
    precision = precision or 0
    neg = value < 0
    power = Math.pow(10, precision)
    value = Math.round(value * power)
    integral = String(((if neg then Math.ceil else Math.floor))(value / power))
    fraction = String(((if neg then -value else value)) % power)
    padding = new Array(Math.max(precision - fraction.length, 0) + 1).join("0")
    (if precision then integral + "." + padding + fraction else integral)

module.exports = m