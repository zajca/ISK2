mongoose = require 'mongoose'
Schema = mongoose.Schema

###
SCHEMA
###
Project = new Schema
  name:
    type: String
    required: true
    index: true
  owner:
    type: Schema.Types.ObjectId
    ref: "User"
  publicated:Boolean
  genres:[
    {
      type: String
      index: true
    }
  ]
  progress:[
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
      status:String
    }
  ]
  compiler:
    type:String
    default: "xelatex"
  rootResourcePath:
    type:String
    default: "main.tex"
  renderPath:String
  files:[
    {
      name:String
      path:String
    }
  ]
  tex_files:[
    {
      path:String
      content:String
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

#HLEDANI PODLE URL
Project.statics.findOneByName = (url, cb)->
  this.findOne({name: name}, cb)

# EXPORT
module.exports = mongoose.model 'Project', Project