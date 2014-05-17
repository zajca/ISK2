mongoose = require 'mongoose'
Schema = mongoose.Schema

###
SCHEMA
###
Config = new Schema
  key:
    type: String
    required: true
    unique: true
    index: true
  value: Schema.Types.Mixed


# EXPORT
module.exports = mongoose.model 'Config', Config