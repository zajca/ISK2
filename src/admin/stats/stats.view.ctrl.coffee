'use strict'

module.exports = ["$scope","socketIO","ngTableParams","$filter",($scope,io,ngTableParams,$filter)->
  # socket = io.connect('/')
  data = []
  pages = []
  lastPageId = 0
  $scope.connections = 0
  $scope.tableParams = new ngTableParams(
    page: 1 # show first page
    count: 10 # count per page
  ,
    total: data.length # length of data
    getData: ($defer, params) ->
      # use build-in angular filter
      #filteredData = (if params.filter() then $filter("filter")(data, params.filter()) else data)
      orderedData = (if params.sorting() then $filter("orderBy")(data, params.orderBy()) else data)
      params.total orderedData.length # set total for recalc pagination
      $defer.resolve orderedData.slice((params.page() - 1) * params.count(), params.page() * params.count())
  )
  $scope.pagesParams = new ngTableParams(
    page: 1 # show first page
    count: 10 # count per page
  ,
    total: pages.length # length of data
    getData: ($defer, params) ->
      # use build-in angular filter
      #filteredData = (if params.filter() then $filter("filter")(data, params.filter()) else data)
      orderedData = (if params.sorting() then $filter("orderBy")(pages, params.orderBy()) else pages)
      params.total orderedData.length # set total for recalc pagination
      $defer.resolve orderedData.slice((params.page() - 1) * params.count(), params.page() * params.count())
  )

  stats=(msg)->
    console.log "msg",msg,"pages",pages
    if pages.length!=0
      for page in pages
        if page.url == msg.url.href
          page.views++
        else
          pages.push({url:msg.url.href,views: 1, pageId: ++lastPageId})
    else
      pages.push({url:msg.url.href,views: 1, pageId: ++lastPageId})
    console.log "pages",pages
    $scope.pagesParams.reload()

  io.on 'connect', ()->
    io.on 'pageview', (msg)->
      $scope.connections = msg.connections || 0
      if msg.ip?
        data.unshift(msg)
        stats(msg)
        $scope.tableParams.reload()
]
