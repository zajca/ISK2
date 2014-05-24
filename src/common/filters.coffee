'use strict'

m = angular.module('filters',[])
m.filter "orderObjectBy", ->
  (input, attribute) ->
    return input  unless angular.isObject(input)
    array = []
    for objectKey of input
      array.push input[objectKey]
    array.sort (a, b) ->
      a = parseInt(a[attribute])
      b = parseInt(b[attribute])
      a - b
    array

module.exports = m