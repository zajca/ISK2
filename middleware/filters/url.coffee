###
Zavislosti modulu.
###
diacritics = require(process.cwd() + "/middleware/filters/diacritics")

###
Prevede retezec na format pro URL.
Provede tyto upravy:
- odstrani ze zacatku a z konce mezery
- bile znaky prevede na pomlcky
- odstrani z retezce diakritiku
- prevede retezec na mala pismena
- odstrani vse mimo alfanumerickych znaku a pomlcky
@param {String} str
@return {String}
###
module.exports = (str) ->
  url = str or ""
  url = url.trim()
  url = url.replace(/\s+/g, "-")
  url = diacritics(url)
  url = url.toLowerCase()
  url = url.replace(/[^a-z0-9-]+/g, "")
  url