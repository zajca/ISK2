moment = require("moment")
crypto = require("crypto")
filter = require("password-filter")
config = require(process.cwd() + "/middleware/auth/config")

exports =
  ###
  @param {String} systemSalt
  @param {String} userSalt
  @return {String}
  ###
  createSalt: (systemSalt, userSalt) ->
    systemSalt + "|" + userSalt


  ###
  @param {String} passwordPlain
  @param {String} userCookieSalt
  @param {Function} cb
  ###
  createCookieToken: (passwordPlain, userCookieSalt, cb) ->
    salt = @createSalt(config.options.systemCookieSalt, userCookieSalt)
    options =
      salt: salt
      iterations: config.options.cookieIterations
      keylen: config.options.cookieKeylen

    filter passwordPlain, options, cb

  createStorageToken: (userStorageSalt, randomString, date) ->
    token = crypto.createHash("sha256").update(config.options.systemStorageSalt).update(userStorageSalt).update(randomString).update(String(date)).digest("hex")
    token


  ###
  @param {String} passwordPlain
  @param {Number} date
  @param {Function} cb
  ###
  createStorageToken: (userStorageSalt, date, cb) ->
    crypto.randomBytes config.options.randomBytesSize, (err, buf) ->
      return cb(err)  if err
      randomString = buf.toString("hex")
      randomHash = createStorageToken(userStorageSalt, randomString, date)
      cb null,
        str: randomString
        hash: randomHash

  ###
  @param {Number} expires
  @param {Boolean}
  ###
  isValidDate: (expires) ->
    today = Date.now()
    expires >= today


  ###
  @param {String} passwordPlain
  @param {Number} date
  @param {Function} cb
  ###
  isValidStorageToken: (storageToken, userStorageSalt, randomString, date) ->
    result = createStorageToken(userStorageSalt, randomString, date)
    result = storageToken is result
    return false  unless result
    @isValidDate date


  ###
  @param {String} passwordPlain
  @param {String} userCookieSalt
  @param {String} userPasswordSalt
  @param {Function} cb
  @return {String}
  ###
  createPassword: (passwordPlain, userCookieSalt, userPasswordSalt, cb) ->
    @createCookieToken passwordPlain, userCookieSalt, ((err, cookieToken) ->
      return cb(err)  if err
      @createPasswordFromCookieToken cookieToken, userPasswordSalt, cb
      return
    ).bind(this)

  ###
  @param {String} cookieToken
  @param {String} userPasswordSalt
  @param {Ftring} cb
  ###
  createPasswordFromCookieToken: (cookieToken, userPasswordSalt, cb) ->
    salt = @createSalt(config.options.systemPasswordSalt, userPasswordSalt)
    options =
      salt: salt
      iterations: config.options.passwordIterations
      keylen: config.options.passwordKeylen

    filter cookieToken, options, cb
