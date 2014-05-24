mongoose = require 'mongoose'
Schema = mongoose.Schema
genid = require("genid")

Session = new Schema
  user:
    name:String
    surname:String
    email:String
    roles:
      type: [String]
      default: ['anonym']
    special:
      allow: [String]
      deny: [String]
    doc:
      type: Schema.ObjectId
      ref: "User"
  last_access:
    type: Date,
    index: true,
    'default': Date.now
  public_id:
    type: String,
    'default': genid

module.exports = mongoose.model 'Session', Session
