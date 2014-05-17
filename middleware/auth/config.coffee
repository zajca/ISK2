Auth = {}
Auth.options = {}
Auth.set = (options) ->
  required = [
    "systemCookieSalt"
    "systemStorageSalt"
    "systemPasswordSalt"
    "systemSignedCookieSalt"
    "cookieIterations"
    "passwordIterations"
    "cookieKeylen"
    "passwordKeylen"
    "randomBytesSize"
    "maxAge"
    "tokenName"
    "httpHeader"
  ]
  i = 0

  while i < required.length
    throw new Error("Option " + required[i] + " is required.")  unless required[i] of options
    ++i
  Auth.options = options

Auth.setModel = (model) ->
  Auth.options.model = model

module.exports = Auth