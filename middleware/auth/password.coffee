crypto = require("crypto")
crypt = require(process.cwd() + "/middleware/auth/crypt")
module.exports = exports = (schema, options) ->
  schema.pre "validate", (next) ->
    field = options.field or "password"
    return next()  if typeof this[field] is "undefined"
    password = this[field]
    return next()  if password is ""
    return next()  unless @isModified(field)
    crypt.createPassword password, @cookieTokenSalt, @passwordSalt, ((err, result) ->
      return next(err)  if err
      @password = result
      next()
    ).bind(this)
