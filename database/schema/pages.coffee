mongoose = require 'mongoose'
Schema = mongoose.Schema
url = require(process.cwd() + "/filters/url")

###
SCHEMA
###
Page = new Schema
  title:
    type: String
    required: true
  url:
    type: String
    index: true
  content:String
  img:[
    {
      name:String
      img:String
    }
  ]
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
addUrl = (page)->
  if (typeof page.url == 'undefined')
    page.url = url(page.name)


#HLEDANI PODLE URL
Page.statics.findOneByUrl = (url, cb)->
  this.findOne({url: url}, cb)
# Book.create = ->

# Book.canDownloadBook = ->

# EXPORT
module.exports = mongoose.model 'Page', Page