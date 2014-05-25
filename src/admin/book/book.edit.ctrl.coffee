'use strict'

module.exports = ["$scope","bookApi","$stateParams","$fileUploader", ($scope,api,$stateParams,$fileUploader) ->
  console.log "ctrl"
  api.get($stateParams.id).then((res)->
    $scope.book = res.data
  )
  $scope.save = (book)->
    api.update(book)

  uploader = $scope.uploader = $fileUploader.create(
    scope: $scope
    url: "/api/v1/file"
  )
  # ADDING FILTERS
  # Images only
  uploader.filters.push (item) -> #{File|HTMLInputElement}
    type = (if uploader.isHTML5 then item.type else "/" + item.value.slice(item.value.lastIndexOf(".") + 1))
    type = "|" + type.toLowerCase().slice(type.lastIndexOf("/") + 1) + "|"
    "|jpg|png|jpeg|bmp|gif|".indexOf(type) isnt -1

  # REGISTER HANDLERS
  uploader.bind "afteraddingfile", (event, item) ->
    console.info "After adding a file", item
  uploader.bind "whenaddingfilefailed", (event, item) ->
    console.info "When adding a file failed", item
  uploader.bind "afteraddingall", (event, items) ->
    console.info "After adding all files", items
  uploader.bind "beforeupload", (event, item) ->
    console.info "Before upload", item
  uploader.bind "progress", (event, item, progress) ->
    console.info "Progress: " + progress, item
  uploader.bind "success", (event, xhr, item, response) ->
    console.info "Success", xhr, item, response
  uploader.bind "cancel", (event, xhr, item) ->
    console.info "Cancel", xhr, item
  uploader.bind "error", (event, xhr, item, response) ->
    console.info "Error", xhr, item, response
  uploader.bind "complete", (event, xhr, item, response) ->
    console.info "Complete", xhr, item, response
  uploader.bind "progressall", (event, progress) ->
    console.info "Total progress: " + progress
  uploader.bind "completeall", (event, items) ->
    console.info "Complete all", items
]
