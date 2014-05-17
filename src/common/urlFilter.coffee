
###
Trida pro zpracovani parametru v URL pri parametrickem hledani/strankovani.

Konfiguracni parametry:
limit - maximalni pocet objektu na stranku
orderColumns - sloupce, podle kterych je mozne radit

@param {Object} config Konfiguracni objekt.
###
UrlFilter = (config) ->
  @_limit = config.limit
  @_orderColumns = config.orderColumns
  @_params = {}
  return

###
Vraci vsechny parametry z URL.

@return {Object}
###
UrlFilter::getParams = ->
  @_params


###
Vraci hodnotu jednoho parametru z URL.
Pokud parametr neexistuje, vraci se hodnota predana v parametru def.

@param {String} name Nazev parametru
@param {String} def  Defaultni hodnota
@return {Object}
###
UrlFilter::getParam = (name, def) ->
  return def  if @_isUndefined(@_params[name])
  @_params[name]


###
Vraci hodnotu jednoho parametru v parametru filter.
Pokud hodnota neexistuje, vraci se hodnota predana v parametru def.

Priklad URL:
/abc?filter=aaa:2@bbb:7,3

ps.getFilterParam('aaa') vrati ['2']
ps.getFilterParam('bbb') vrati ['7','3']
ps.getFilterParam('ccc', 42) vrati '42'

@param {String} name Nazev parametru
@param {String} def  Defaultni hodnota
@return {Object}
###
UrlFilter::getFilterParam = (name, def) ->
  filter = @getParam("filter")
  return def  if @_isUndefined(filter)
  return def  if @_isUndefined(filter[name])
  filter[name]


###
Vraci hodnotu jednoho parametru v parametru filter jako retezec.
Pokud hodnota neexistuje, vraci se hodnota predana v parametru def.

Priklad URL:
/abc?filter=aaa:2@bbb:7,3

ps.getFilterParam('aaa') vrati '2'

@param {String} name Nazev parametru
@param {String} def  Defaultni hodnota
@return {Object}
###
UrlFilter::getFilterParamAsString = (name, def) ->
  @getFilterParam(name, def).toString()


###
Nahraje paramtry z URL.

@param {Object} params
###
UrlFilter::setParams = (params) ->
  @_params = params
  @_parseFilter()
  return


###
Vraci pocet polozek na stranku.

@return {Number}
###
UrlFilter::getLimit = ->
  @_limit


###
Vraci aktualni cislo stranky.

Nejmensi cislo stranky je 1, pokud je cislo stranky nizsi, je vracena 1.

@return {Number}
###
UrlFilter::getPage = ->
  offset = @_params.offset
  return 1  if @_isUndefined(offset)
  page = (offset / @getLimit()) + 1
  return 1  if page < 1
  return 1  if offset % @getLimit() isnt 0
  page


###
Vrati cislo zaznamu, od ktereho se maji vracet vysledky.

@return {Number}
###
UrlFilter::getOffset = ->
  return 0  if @getPage() is 1
  @_params.offset


###
Vraci sloupec, podle ktereho se ma radit.
Neni-li predan jako parametr, vezme se prvni z testovanych sloupcu.

@return {String}
###
UrlFilter::getOrder = ->
  key = @_orderColumns.indexOf(@_params.order)
  if ~key
    @_orderColumns[key]
  else
    @_orderColumns[0]


###
Projde vsechny parametry v parametru filter a vytvori z nich objekt.

Priklad URL:
/abc?order=price&filter=aaa:2@bbb:7,3

ps.getParams() vrati {order: price, filter: {aaa: ['2'], bbb: ['7', '3']}}
###
UrlFilter::_parseFilter = ->
  params = {}
  filter = @_params.filter
  if @_isString(filter)
    filter.split("@").forEach (rule) ->
      parts = rule.split(":")
      return  if parts.length isnt 2
      params[parts[0]] = parts[1].split(",")
      return

  @_params.filter = params
  return

UrlFilter::_isUndefined = (val) ->
  typeof val is "undefined"

UrlFilter::_isString = (val) ->
  typeof val is "string"