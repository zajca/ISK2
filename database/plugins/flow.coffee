fs = require("fs")
path = require("path")
util = require("util")
Stream = require("stream").Stream
module.exports = flow = (temporaryFolder) ->
  $ = this
  $.temporaryFolder = temporaryFolder
  $.maxFileSize = null
  $.fileParameterName = "file"
  try
    fs.mkdirSync $.temporaryFolder
  cleanIdentifier = (identifier) ->
    identifier.replace /^0-9A-Za-z_-/g, ""

  getChunkFilename = (chunkNumber, identifier) ->
    # Clean up the identifier
    identifier = cleanIdentifier(identifier)
    # What would the file name be?
    path.join $.temporaryFolder, "./flow-" + identifier + "." + chunkNumber

  validateRequest = (chunkNumber, chunkSize, totalSize, identifier, filename, fileSize) ->
    # Clean up the identifier
    identifier = cleanIdentifier(identifier)
    # Check if the request is sane
    return "non_flow_request"  if chunkNumber is 0 or chunkSize is 0 or totalSize is 0 or identifier.length is 0 or filename.length is 0
    numberOfChunks = Math.max(Math.floor(totalSize / (chunkSize * 1.0)), 1)
    return "invalid_flow_request1"  if chunkNumber > numberOfChunks
    # Is the file too big?
    return "invalid_flow_request2"  if $.maxFileSize and totalSize > $.maxFileSize
    unless typeof (fileSize) is "undefined"
      # The chunk in the POST request isn't the correct size
      return "invalid_flow_request3"  if chunkNumber < numberOfChunks and fileSize isnt chunkSize
      # The chunks in the POST is the last one, and the fil is not the correct size
      return "invalid_flow_request4"  if numberOfChunks > 1 and chunkNumber is numberOfChunks and fileSize isnt ((totalSize % chunkSize) + chunkSize)
      # The file is only a single chunk, and the data size does not fit
      return "invalid_flow_request5"  if numberOfChunks is 1 and fileSize isnt totalSize
    "valid"

  #'found', filename, original_filename, identifier
  #'not_found', null, null, null
  $.get = (req, callback) ->
    chunkNumber = req.param("flowChunkNumber", 0)
    chunkSize = req.param("flowChunkSize", 0)
    totalSize = req.param("flowTotalSize", 0)
    identifier = req.param("flowIdentifier", "")
    filename = req.param("flowFilename", "")
    if validateRequest(chunkNumber, chunkSize, totalSize, identifier, filename) is "valid"
      chunkFilename = getChunkFilename(chunkNumber, identifier)
      fs.exists chunkFilename, (exists) ->
        if exists
          callback "found", chunkFilename, filename, identifier
        else
          callback "not_found", null, null, null
    else
      callback "not_found", null, null, null
  #'partly_done', filename, original_filename, identifier
  #'done', filename, original_filename, identifier
  #'invalid_flow_request', null, null, null
  #'non_flow_request', null, null, null
  $.post = (req, callback) ->
    fields = req.body
    files = req.files
    chunkNumber = fields["flowChunkNumber"]
    chunkSize = fields["flowChunkSize"]
    totalSize = fields["flowTotalSize"]
    identifier = cleanIdentifier(fields["flowIdentifier"])
    filename = fields["flowFilename"]
    original_filename = fields["flowIdentifier"]
    if not files[$.fileParameterName] or not files[$.fileParameterName].size
      callback "invalid_flow_request", null, null, null
    validation = validateRequest(chunkNumber, chunkSize, totalSize, identifier, files[$.fileParameterName].size)
    if validation is "valid"
      chunkFilename = getChunkFilename(chunkNumber, identifier)
      # Save the chunk (TODO: OVERWRITE)
      fs.rename files[$.fileParameterName].path, chunkFilename, ->
        # Do we have all the chunks?
        currentTestChunk = 1
        numberOfChunks = Math.max(Math.floor(totalSize / (chunkSize * 1.0)), 1)
        testChunkExists = ->
          fs.exists getChunkFilename(currentTestChunk, identifier), (exists) ->
            if exists
              currentTestChunk++
              if currentTestChunk > numberOfChunks
                callback "done", filename, original_filename, identifier
              else
                # Recursion
                testChunkExists()
            else
              callback "partly_done", filename, original_filename, identifier
        testChunkExists()
    else
      callback validation, filename, original_filename, identifier
  # Pipe chunks directly in to an existsing WritableStream
  #   r.write(identifier, response);
  #   r.write(identifier, response, {end:false});
  #
  #   var stream = fs.createWriteStream(filename);
  #   r.write(identifier, stream);
  #   stream.on('data', function(data){...});
  #   stream.on('end', function(){...});
  $.write = (identifier, writableStream, options) ->
    options = options or {}
    options.end = ((if typeof options["end"] is "undefined" then true else options["end"]))
    # Iterate over each chunk
    pipeChunk = (number) ->
      chunkFilename = getChunkFilename(number, identifier)
      fs.exists chunkFilename, (exists) ->
        if exists
          # If the chunk with the current number exists,
          # then create a ReadStream from the file
          # and pipe it to the specified writableStream.
          sourceStream = fs.createReadStream(chunkFilename)
          sourceStream.pipe writableStream,
            end: false

          sourceStream.on "end", ->
            # When the chunk is fully streamed,
            # jump to the next one
            pipeChunk number + 1
        else
          # When all the chunks have been piped, end the stream
          writableStream.end()  if options.end
          options.onDone()  if options.onDone
    pipeChunk 1

  $.clean = (identifier, options) ->
    options = options or {}
    # Iterate over each chunk
    pipeChunkRm = (number) ->
      chunkFilename = getChunkFilename(number, identifier)
      #console.log('removing pipeChunkRm ', number, 'chunkFilename', chunkFilename);
      fs.exists chunkFilename, (exists) ->
        if exists
          console.log "exist removing ", chunkFilename
          fs.unlink chunkFilename, (err) ->
            opentions.onError err  if options.onError
          pipeChunkRm number + 1
        else
          options.onDone()  if options.onDone
    pipeChunkRm 1
  $