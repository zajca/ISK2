mongoose = require 'mongoose'
Schema = mongoose.Schema

###
SCHEMA
###
Log = new Schema
  user:
    email: String
    name: String
    surname: String
    reference:
      type: Schema.Types.ObjectId
      ref: "User"
  msg: String
  data: Schema.Types.Mixed
  event: String
  level: String
  User_Agent:String
  remoteAddress: String
  X_forwarded_for: String
  created_at:
    type:Date
    default: Date.now

# EXPORT
module.exports = mongoose.model 'Log', Log