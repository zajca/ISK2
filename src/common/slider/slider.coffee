module.exports = ["$timeout","index.api","$log","$interval",($timeout,api,$log,$interval)->
  restrict:'E'
  transclude: true
  scope:
    state: '@'
    slideWidth: "@"
  replace:true
  template:'
  <div class="slider_wrapper">
  <ul class="slider" hm-drag-left="dragLeft($event)" hm-drag-right="dragRight($event)" hm-dragend="dragEnd()" ng-class="{drag:draging}" msd-wheel="wheel($event)">
    <li ng-repeat="m in model track by $index" ui-sref="book.view({id:m._id})" class="dn-fade-down">
      <img ng-src="m.img.small" onError="this.onerror=null;this.src=\'http://placehold.it/200x309/6888cea/ffffff/kniha\';"/>
      <div ng-if="hover">
        {{m.description}}
      </div>
    </li>
  </ul>
  <span class="clear"></span>
          <div class="hoverLeft" ng-hide="hideSmall||hideLeft" ng-mouseleave="slideStop()"><div ng-mouseover="slide(\'right\')" ng-mouseleave="slideStop()"><i class="fa fa-arrow-left"></i></div></div>
          <div class="hoverRight" ng-hide="hideSmall||hideRight" ng-mouseleave="slideStop()"><div ng-mouseover="slide(\'left\')" ng-mouseleave="slideStop()"><i class="fa fa-arrow-right"></i></div></div>
        </div>'
  link:(scope, iElm, iAttrs)->
    _init=false
    scope.model = []
    DOM={}
    _left=0
    _offsetSlideRight=0
    #LOAD resources
    load=->
      api.fetch().then((res)->
        scope.model = res.data
        init()
      )

    #init directive
    init=->
      DOM.parent = iElm.parent()
      DOM.width = DOM.parent[0].offsetWidth
      DOM.slider = angular.element(iElm[0].children)
      DOM.slideWidth = scope.slideWidth||200
      _init=true
      console.log(scope.model)
      updateSize(scope.model.length)
      scope.hideLeft=true
    #update size of directive
    updateSize=(nInList)->
      if _init
        $log.debug nInList,DOM.slideWidth
        DOM.slider[0].style.width = (nInList*DOM.slideWidth+100) + 'px'
        _offsetSlideRight = DOM.width-(nInList*DOM.slideWidth+100)
        if _offsetSlideRight>0
          scope.hideSmall = true
    _lastDistance=0
    _cursorPosition=undefined
    scope.hideRight=false
    scope.hideLeft=false
    dragUpdate=(direction,distance)->
      scope.draging=true
      if direction=="left"
        left = _left-distance
        if left<50 and left>_offsetSlideRight
          scope.hideLeft=false
          _left=left
          DOM.slider[0].style.left = _left + 'px'
        else
          scope.hideRight=true
      else
        left = _left+distance
        if left<50 and left>_offsetSlideRight
          scope.hideRight=false
          _left=left
          DOM.slider[0].style.left = _left + 'px'
        else
          scope.hideLeft=true

    scope.dragLeft=(e)->
      e.preventDefault()
      distance = e.gesture.distance-_lastDistance
      _lastDistance = e.gesture.distance
      dragUpdate("left",distance)

    scope.dragRight=(e)->
      e.preventDefault()
      distance = e.gesture.distance-_lastDistance
      _lastDistance = e.gesture.distance
      dragUpdate("right",distance)

    _interval=null
    scope.slide=(direction)->
      _interval = $interval(->
        dragUpdate(direction,10)
      ,50)

    scope.slideStop=->
      $interval.cancel(_interval)

    scope.wheel=(e)->
      e.preventDefault()
      if e.wheelDelta<0
        dragUpdate("right",30)
      else
        dragUpdate("left",30)

    scope.dragEnd=->
      _cursorPosition=undefined
      _lastDistance=0
      scope.draging=false
      
    updateFileds=(newVal)->
      length = newVal.length+scope.model.length
      updateSize(length)
      
    $timeout(load,0)
]