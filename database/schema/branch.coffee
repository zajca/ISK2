mongoose = require 'mongoose'
Schema = mongoose.Schema

###
SCHEMA
###
Branch = new Schema
  name:
    type: String
    required: true
  supervisor:
    type: Schema.Types.ObjectId
    ref: "User"    
  employes:[
    {
      type: Schema.Types.ObjectId
      ref: "User"
    }
  ]
  books_on_sale:[
    {
      type: Schema.Types.ObjectId
      ref: "Book"
    }
  ]
  books_to_arrive:[
    {
      type: Schema.Types.ObjectId
      ref: "User"
    }
  ]
  orders:[
    {
      type: Schema.Types.ObjectId
      ref: "Order"
    }
  ]
  address:
    state: String
    city: String
    street: String
    postal: Number
    home_number: Number
    type: String

  contacts:[
    {
      name: String
      description: String
      tel: String
      tel2: String
      email: String
    }
  ]
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


# EXPORT
module.exports = mongoose.model 'Branch', Branch