mongoose = require 'mongoose'
Schema = mongoose.Schema
url = require(process.cwd() + "/filters/url")

###
SCHEMA
###
Book = new Schema
  name:
    type: String
    required: true
    index: true
  author:
    type: String
    required: true
  url:
    type: String
  owner:
    type: Schema.Types.ObjectId
    ref: "User"
  buyers:[
    type: Schema.Types.ObjectId
    ref: "User"
  ]
  img:
    small:
      data: Buffer
      contentType: String
    big:
      data: Buffer
      contentType: String
  genres:[
    text:String
  ]
  keywords:[
    text:String
  ]
  number_of_sales:
    type:Number
    required:false
  commets:[
    {
      author:
        type: String
        require: true
      comment:
        type: String
        require: true
      user:
        type: Schema.Types.ObjectId
        ref: "User"
    }
  ]
  rating:[
    {
      value:
        type: Number
        require: true
      user:
        type: Schema.Types.ObjectId
        ref: "User"
    }
  ]
  render:
    type: Schema.Types.ObjectId
    ref: "File"
  avaible:Boolean
  outoforder:Boolean
  public:Boolean
  preorder:Boolean
  out_of_order:Boolean

  delivery_msg:String
  price:Number
  released:Date
  public_from:Date
  buy_allowed_from:Date
  description:String
  price_hystory:[
    {
      date:
        type:Date
        default: Date.now
      value:
        type:Number
    }
  ]
  pages:
    type: Number
    required: true
  meta: [
      {
        key: String
        value: String
      }
    ]
  updated_at:
    type:Date
    default: Date.now
  created_at:
    type:Date
    default: Date.now

#GENEROVANI URL
addUrl = (book)->
  if (typeof book.url == 'undefined')
    book.url = url(book.name)
#KONTROLA URL
Book.pre 'validate', (next)->
  addUrl this
  next()
#HLEDANI PODLE URL
Book.statics.findOneByUrl = (url, cb)->
  this.findOne({url: url}, cb)

Book.statics.findOneById = (id, cb)->
  this.findOne({_id: id}, cb)

Book.statics.create = (id, cb)->
  this.findOne({_id: id}, cb)

# EXPORT
module.exports = mongoose.model 'Book', Book
