module.exports = ["$timeout","index.api","$log",($timeout,api,$log)->
  restrict:'E'
  transclude: true
  scope:
    state: '@'
    slideWidth: "@"
  replace:true
  template:'
  <div class="slider_wrapper">
  <ul class="slider" hm-drag-left="dragLeft($event)" hm-drag-right="dragRight($event)" hm-dragend="dragEnd()">
    <li ng-repeat="m in model track by $index" ui-sref="book.detail({id:{{m.id}}})">
      <img ng-src="{{m.url}}"/>
      <div ng-if="hover">
        {{m.hover}}
      </div>
    </li>
  </ul>
  </div>'
  link:(scope, iElm, iAttrs)->
    _init=false
    scope.model = []
    DOM={}
    _left=0
    _offsetSlideRight=0
    
    #LOAD resources
    load=->
      scope.model =[]
      api.fetch().then((res)->
        scope.model
        $log.debug "scope.model",scope.model
        init()
      )
    #init directive
    init=->
      DOM.parent = iElm.parent()
      DOM.width = DOM.parent[0].offsetWidth
      DOM.slider = angular.element(iElm[0].children)
      DOM.slideWidth = scope.slideWidth||0
      _init=true
      updateSize(scope.model.length)
    
    #update size of directive
    updateSize=(nInList)->
      if _init
        $log.debug nInList,DOM.slideWidth
        DOM.slider[0].style.width = (nInList*DOM.slideWidth+100) + 'px'
        _offsetSlideRight = DOM.width-(nInList*DOM.slideWidth+100)
    
    _lastDistance=0
    _cursorPosition=undefined
    
    dragUpdate=(direction,e)->
      e.preventDefault()
      if _cursorPosition == undefined
        _cursorPosition =  e.gesture.center.clientX
      distance = e.gesture.distance-_lastDistance
      _lastDistance = e.gesture.distance
      

      if _left>_offsetSlideRight && _left<100
        if direction=="left"
          _left-= distance
        else
          _left+= distance
        DOM.slider[0].style.left = _left + 'px'
        
      if _left<=_offsetSlideRight
        $log.debug "next"
        toPush = api.next()
        for i in toPush
          scope.model.push(i)
        updateSize(scope.model.length)
          
      if _left>=100
        $log.debug "prev"
        toPush = api.prev()
        for i in toPush
          scope.model.unshift(i)
        _left-= toPush.length*DOM.slideWidth
        DOM.slider[0].style.left = _left + 'px'
        updateSize(scope.model.length)
        
      $log.debug scope.model

    scope.dragLeft=(e)->
      dragUpdate("left",e)

    scope.dragRight=(e)->
      dragUpdate("right",e)
      
    scope.dragEnd=->
      _cursorPosition=undefined    
      _lastDistance=0
      
    updateFileds=(newVal)->
      length = newVal.length+scope.model.length
      updateSize(length)
      
    $timeout(load,0)
]