'use strict'

module.exports = ["$stateProvider",($stateProvider) ->
  $stateProvider.state("book",
    url: "/book"
    abstract: true
    views:
      main:
        template: "<ui-view/>"
  ).state("book.view",
    url: "/:id"
    controller: "bookViewCtrl"
    templateUrl: "/build/partials/store/book/book.view.tpl.html"
    resolve:
      book: ($stateParams,bookApi)->
        bookApi.getBook($stateParams.id).then((res)->
          res.data
        )
  )
]