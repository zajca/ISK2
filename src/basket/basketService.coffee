'use strict'


module.exports = ["localStorageService","$rootScope",(ls,root) ->
  add: (item,n)->
    items = ls.get('basketItems') || []
    item.n = n || 1
    items.push item
    ls.set("basketItems",items)
    root.$broadcast("BASKET_UPDATE")

  sum: ->
    items = ls.get('basketItems') || []
    price = 0
    n=0
    for i in items
      n+=i.n
      price+=(i.price*i.n)

    {"price":price,"n":n}

  remove: (id)->
    items = ls.get('basketItems') || []
    for key,i in items
      if i.id == id
        items.splice(key,1)

    ls.set("basketItems",items)
    root.$broadcast("BASKET_UPDATE")

  removeByIndex: (index)->
    items = ls.get('basketItems') || []
    items.splice(index,1)

    ls.set("basketItems",items)
    root.$broadcast("BASKET_UPDATE")

  inc: (index)->
    items = ls.get('basketItems') || []
    items[index].n++
    ls.set("basketItems",items)
    root.$broadcast("BASKET_UPDATE")

  dec: (index)->
    items = ls.get('basketItems') || []
    if items[index].n < 2
      items.splice(index,1)
    else
      items[index].n--
          
    ls.set("basketItems",items)
    root.$broadcast("BASKET_UPDATE")

  get: ->
    ls.get("basketItems")

  clear: ->
    ls.remove("basketItems")
    root.$broadcast("BASKET_UPDATE")
]