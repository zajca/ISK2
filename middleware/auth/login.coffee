config = require(process.cwd() + "/middleware/auth/config")
crypt = require(process.cwd() + "/middleware/auth/crypt")
error = require(process.cwd() + "/middleware/error")

###
@returns {Function}
###
module.exports = ->
  ###
  @param {ServerRequest} req
  @param {ServerResponse} res
  @param {Function} next
  ###
  login: (req, res, next) ->
    password = req.body.password
    condition = email: req.body.email
    config.options.model.findOne condition, (err, user) ->
      return next(err)  if err
      return sendError(next)  unless user
      crypt.createCookieToken password, user.cookieTokenSalt, (err, cookieToken) ->
        return next(err)  if err
        crypt.createPasswordFromCookieToken cookieToken, user.passwordSalt, (err, hash) ->
          return next(err)  if err
          if user.password is hash
            sendSuccess res, user, cookieToken, next
          else
            sendError next


###
@param {Function} next
###
sendSuccess = (res, user, cookieToken, next) ->
  expires = Date.now() + user.tokenMaxAge * 1000
  crypt.createStorageToken user.storageTokenSalt, expires, (err, random) ->
    return next(err)  if err
    cookie =
      token: cookieToken
      user: user.id
      randomString: random.str
      expires: expires

    res.cookie config.options.tokenName, cookie,
      expires: new Date(expires)
      httpOnly: true
      signed: true

    response = {}
    response[config.options.tokenName] = random.hash
    res.send response

###
@param {Function} next
###
sendError = (next) ->
  next new error.InvalidLoginData()