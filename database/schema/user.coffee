mongoose = require 'mongoose'
Schema = mongoose.Schema
generateHash = require 'mongoose-hash'
# Promise = require('bluebird')
password = require(process.cwd() + "/middleware/auth/password")
config = require(process.cwd() + "/middleware/auth/config")

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
  tokenMaxAge:
    type: Number
    required: true
    default: config.options.maxAge
  cookieTokenSalt:
    type: String
    required: true
  storageTokenSalt:
    type: String
    required: true
  passwordSalt:
    type: String
    required: true
  password:
    type: String
    required: true
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
  payed_books:
    [
      type: Schema.Types.ObjectId
      ref: "Book"
    ]
  roles:
    type: [String]
    default: ['anonymous']
  special:
    canRead:
      projects:[
        type: Schema.Types.ObjectId
        ref: "Project"
      ]
    canEdit:
      projects:[
        type: Schema.Types.ObjectId
        ref: "Project"
      ]
  UserAgent:String
  remoteAddress:String
  XForwardedFor:String
  last_login:
    type:Date
    default: Date.now
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
User.plugin generateHash,
  field: "cookieTokenSalt"
  size: 64

User.plugin generateHash,
  field: "storageTokenSalt"
  size: 64

User.plugin generateHash,
  field: "passwordSalt"
  size: 64

User.plugin password,
  field: "password"


# User.addImg = (file, options, fn) ->
#   gridfs.putFile file.path, file.filename, options, (err, result) ->
#     this.img = result
#     this.save fn

# User.getImg = (file, options, fn) ->
#   gridfs.get req.params.id, (err, file) ->
#     res.header "Content-Type", file.type
#     res.header "Content-Disposition", "attachment; filename=#{file.filename}"
#     file.stream(true).pipe(res)

User.create = ->

User.canDownloadBook = (id, options, fn) ->
  if id in this.payed_books
    true

# EXPORT
module.exports = mongoose.model 'User', User