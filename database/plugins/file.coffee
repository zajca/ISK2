module.exports =
  uploadFile:  (req, res) ->
    file = req.files.upload
    docId = mongoose.Types.ObjectId(req.query.docId)
    filename = req.query.ileName
    contentType = file.type
    return res.send(result: "NO_FILE_UPLOADED")  unless file
    writestream = gfs.createWriteStream(
      _id: docId
      filename: filename
      mode: "w"
      root: "documents"
    )

  downloadFile: (req, res) ->
    docId = mongoose.Types.ObjectId(req.query.docId)
    readstream = gfs.createReadStream(_id: docId)
    readstream.pipe res
