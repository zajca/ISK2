module.exports = [
  "$scope",
  "$modal",
  ($scope,$modal)->

    $scope.languageModal = ->
      $modal(
        title: 'My Title',
        content: 'My Content',
        show: true
        animation: "am-fade-and-slide-top"
      )

    # $scope.languageModal =
    #   title: "Title"
    #   content: "Hello Modal<br />This is a multiline message!"
  
]