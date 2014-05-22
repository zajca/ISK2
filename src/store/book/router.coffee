'use strict'

m = angular.module("book.router", [])

m.config(
  ["$stateProvider",($stateProvider) ->
    $stateProvider.state("book",
      url: "/book/:id"
      views:
        main:
          controller: "BookCtrl"
          templateUrl: "/build/partials/store/book/detail.tpl.html"
    )
    # .state("book.edit",
    #   url: "/book/:id/edit"
    #   views:
    #     main:
    #       controller: "BookEditCtrl"
    #       templateUrl: "partials/store/book/edit.tpl.html"
    # )
  ]
)
module.exports = m