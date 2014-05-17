config = require(process.cwd() + "/middleware/auth/config")
crypt = require(process.cwd() + "/middleware/auth/crypt")

hasAccess = (req, cb) ->
  cookie = req.signedCookies[config.options.tokenName]
  storage = req.get(config.options.httpHeader)
  return cb(null, false)  unless storage and cookie and cookie.user and cookie.token and cookie.randomString and cookie.expires
  config.options.model.findOne
    _id: cookie.user
  , (err, user) ->
    return cb(err)  if err
    return cb(null, false)  unless user
    return cb(null, false)  unless crypt.isValidStorageToken(storage, user.storageTokenSalt, cookie.randomString, cookie.expires)
    crypt.createPasswordFromCookieToken cookie.token, user.passwordSalt, (err, passwordToken) ->
      return cb(err)  if err
      result = passwordToken is user.password
      cb null, result

module.exports = ->
  (req, res, next) ->
    hasAccess req, (err, result) ->
      return next(err)  if err
      return next()  if result
      res.send 401
