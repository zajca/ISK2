config = require(process.cwd() + "/middleware/auth/config")
module.exports = ->
  (req, res, next) ->
    res.clearCookie config.options.tokenName
    res.end()