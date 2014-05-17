mongoose = require 'mongoose'
Schema = mongoose.Schema

###
SCHEMA
###
Troubleshot = new Schema
  title:
    type: String
    required: true
  msg:
    type: String
  user:
    type: Schema.Types.ObjectId
    ref: "User"
  stage:
    type: String
  priority:
    type: String
  conversation:[
    msg:
      type: String
    user:
      type: Schema.Types.ObjectId
      ref: "User"
  ]
  alert_users:[
    type: Schema.Types.ObjectId
    ref: "User"
  ]
# EXPORT
module.exports = mongoose.model 'Troubleshot', Troubleshot