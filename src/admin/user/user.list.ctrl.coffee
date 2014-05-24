'use strict'

module.exports = ["$scope", "$filter", "ngTableParams","users","bookApi",($scope, $filter, ngTableParams,users,api)->
  data = users.data
  $scope.tableParams = new ngTableParams(
    page: 1 # show first page
    count: 10 # count per page
    filter:
      name: "" # initial filter

    sorting:
      name: "asc" # initial sorting
  ,
    total: data.length # length of data
    getData: ($defer, params) ->
      # use build-in angular filter
      filteredData = (if params.filter() then $filter("filter")(data, params.filter()) else data)
      orderedData = (if params.sorting() then $filter("orderBy")(filteredData, params.orderBy()) else data)
      params.total orderedData.length # set total for recalc pagination
      $defer.resolve orderedData.slice((params.page() - 1) * params.count(), params.page() * params.count())
  )
  $scope.remove = (id,index)->
    api.remove(id).then(->
      data.splice(index,1)
      $scope.tableParams.reload()
    )
]