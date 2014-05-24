mongoose = require 'mongoose'
Schema = mongoose.Schema
generateHash = require 'mongoose-hash'
crypto = require "crypto"
config  = require(process.cwd()+"/config").getConfig(process.env.ENV).app
jwt = require('jsonwebtoken')

###
SCHEMA
###
User = new Schema
  email:
    type: String
    required: true
    unique: true
    index: true
  img:
    data: Buffer
    contentType: String
  locale:
    type: String
  name:
    type:String
    required:true
  surname:
    type:String
    required:true
  passwordSalt:
    type: String
  password:
    type: String
    required: true
  token: String
  address:
    [
      state: String
      city: String
      street: String
      postal: Number
      home_number: Number
      type: String
    ]
  billing_address:[
    state: String
    city: String
    street: String
    postal: Number
    home_number: Number
    type: String
  ]
  tel:
    type:String
    required:true
  orders:
    [
      type: Schema.Types.ObjectId
      ref: "Order"
    ]
  projects:
    [
      type: Schema.Types.ObjectId
      ref: "Project"
    ]
  whished_books:
    [
      type: Schema.Types.ObjectId
      ref: "Book"
    ]
  payed_e_books:
    [
      type: Schema.Types.ObjectId
      ref: "Book"
    ]
  payed_books:
    [
      type: Schema.Types.ObjectId
      ref: "Book"
    ]
  favourite_books:
    [
      type: Schema.Types.ObjectId
      ref: "Book"
    ]
  roles:
    type: [String]
    default: ['anonym']
  special:
    allow: [String]
    deny: [String]
  last_login:
    type:Date
    default: Date.now
    UserAgent:String
    remoteAddress:String
    XForwardedFor:String
  meta: [
    key: String
    value: String
  ]
  updated_at:
    type:Date
    default: Date.now
  created_at:
    type:Date
    default: Date.now

# PLUGINS
User.pre "save", (next) ->
  user = this
  salt = crypto.randomBytes(128).toString("base64")
  user.passwordSalt = salt
  crypto.pbkdf2 user.password, salt, 10000, 512, (err, dk) ->
    user.password = Buffer(dk, 'binary').toString('hex')
    next()

User.methods.validPassword = (password,cb) ->
  console.log this.password,this.passwordSalt
  crypto.pbkdf2 password, this.passwordSalt, 10000, 512, (err, dk) =>
    console.log this.password
    if this.password == Buffer(dk, 'binary').toString('hex')
      cb(true)
    else
      cb(false)

User.methods.createToken = (cb)->
  console.log "user",this._id
  token = jwt.sign(
    id: this._id
    name: this.name
    surname:this.surname
    email:this.email
  ,
    config.privateKey
  )
  this.token = token
  cb(token)

User.methods.canDownloadBook = (id, options, fn) ->
  if id in this.payed_books
    true

# EXPORT
module.exports = mongoose.model 'User', User
