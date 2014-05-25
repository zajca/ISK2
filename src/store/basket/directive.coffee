'use strict'

module.exports = [()->
  scope:true
  replace:false
  restrict: 'A'
  template:'<a href class="basketIcon">
    <i class="fa fa-shopping-cart" data-animation="am-flip-x" data-placement="bottom" data-animation="am-flip-x" data-template="/build/partials/store/basket/popover.tpl.html" bs-popover></i>
      <div ng-if="$basket.sum().n!=0">{{$basket.sum().n}}</div>
    </a>'
  controller: ["$scope","$basket",($scope,$basket)->
    $scope.$basket = $basket
  ]
]