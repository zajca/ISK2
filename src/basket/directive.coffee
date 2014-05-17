'use strict'

module.exports = [()->
  scope:true
  replace:false
  restrict: 'A'
  template:'<a href><i class="fa fa-shopping-cart" data-animation="am-flip-x" data-placement="bottom" data-animation="am-flip-x" data-template="/build/partials/basket/popover.tpl.html" bs-popover></i></a>'
  # controller: ["$scope","$basket",($scope,$basket)->
   
  #   ]
]