'use strict'

module.exports = ["$stateProvider",($stateProvider) ->
  $stateProvider.state("book",
    url: "/book"
    abstract: true
    views:
      main:
        template: "<ui-view/>"
  ).state("book.view",
    url: "/book/:id"
    controller: "bookViewCtrl"
    templateUrl: "/build/partials/store/book/book.view.tpl.html"
    resolve:
      book: ["$stateParams","bookApi",(params,api)->
        api.getBook(params.id)
      ]
  )
]