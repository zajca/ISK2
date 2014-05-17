'use strict'
m=angular.module("settings",[])
m.directive "settingsIcon" , require "./directive"
m.controller "dropDownCtrl" , require "./dropDownCtrl"
module.exports = m