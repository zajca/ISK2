'use strict'

module.exports = [() ->
  scope:true
  replace:false
  restrict: 'A'
  template:'<a href><i class="fa fa-cog" placement="bottom-left" data-animation="am-flip-x" data-template="/build/partials/store/settings/dropDown.tpl.html" bs-dropdown="dropdown"></i></a>'
  controller: ["$scope",($scope)->
    $scope.dropdown = [
      {
        icon: "fa-flag"
        text: 'LANGUAGE'
        modal: "languageModal"
      }
      {
        icon: "fa-male"
        text: 'PROFILE'
        modal: "profileModal"
      }
      {
        divider: true
      }
      {
        icon: "fa-pencil"
        text: 'EDIT_SECTION'
        href: "edit"
      }
      {
        divider: true
      }
      {
        icon: "fa-sign-out"
        text: "LOGOUT"
        href: "#separatedLink"
      }
    ]
  ]
]
