'use strict'

require("./../../vendor/angular-local-storage/angular-local-storage")

m = angular.module("basket",["LocalStorageModule"])

m.directive "basketIcon", require("./directive")
m.factory "$basket", require("./basketService")
m.controller "basketCtrl" , require("./controller")

module.exports = m