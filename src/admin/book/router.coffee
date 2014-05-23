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
      templateUrl: "/build/partials/admin/book/book.list.tpl.html"
      controller: "BookListCtrl"
    ).state("book.create",
      url: "/create"
      templateUrl: "/build/partials/admin/book/book.edit.tpl.html"
      controller: "BookCreateCtrl"
    ).state("book.edit",
      url: "/edit/:id"
      templateUrl: "/build/partials/admin/book/book.edit.tpl.html"
      controller: "BookEditCtrl"
    )
  ]