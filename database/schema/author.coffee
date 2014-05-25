mongoose = require 'mongoose'
Schema = mongoose.Schema

###
SCHEMA
###
Author = new Schema
  name:
    type: String
    required: true
  surname:
    type: String
    index: true
  description:String
  birth:
    type:Date
  dead:
    type:Date
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

# EXPORT
module.exports = mongoose.model 'Author', Author