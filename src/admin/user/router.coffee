'use strict'

module.exports = ["$stateProvider",($stateProvider) ->
    $stateProvider.state("user",
      url: "/user/:id"
      views:
        main:
          controller: "userListCtrl"
          templateUrl: "/build/partials/book/detail.tpl.html"
    )
    # .state("book.edit",
    #   url: "/book/:id/edit"
    #   views:
    #     main:
    #       controller: "BookEditCtrl"
    #       templateUrl: "partials/book/edit.tpl.html"
    # )
  ]
