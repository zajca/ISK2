mongoose = require("mongoose")
mongooseFS = require("mongoose-fs")

File = mongoose.Schema(
  name: String
  size: Number
  creation_date:
    type:Date
    default: Date.now
)
File.plugin mongooseFS,
  keys: [
    "content"
    "complement"
  ]
  mongoose: mongoose

module.exports = mongoose.model "File", File