'use strict'

module.exports = ["$stateProvider",($stateProvider) ->
  console.log "router"
  $stateProvider.state("book",
    url: "/book"
    abstract: true
    views:
      main:
        template: "<ui-view/>"
    ).state("book.list",
      url: "/list"
      controller: "BookListCtrl"
      templateUrl: "/build/partials/admin/book/book.list.tpl.html"
      resolve:
        books: (bookApi) ->
          bookApi.fetch()
    ).state("book.create",
      url: "/create"
      controller: "BookCreateCtrl"
      templateUrl: "/build/partials/admin/book/book.edit.tpl.html"
    ).state("book.edit",
      url: "/edit/:id"
      controller: "BookEditCtrl"
      templateUrl: "/build/partials/admin/book/book.edit.tpl.html"
    )
  ]