'use strict'

require "./cz"
m = angular.module("i18n", ["pascalprecht.translate","cs_CZ"])
m.config ["$translateProvider",($translateProvider) ->
  $translateProvider.preferredLanguage "cz"
]
module.exports = m