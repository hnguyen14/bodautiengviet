fs = require 'fs'
byline = require 'byline'
_s = require 'underscore.string'
_ = require('underscore')._
xml2js = require 'xml2js'
db = require '../config/cradle'

stream = fs.createReadStream('/Users/hnguyen/src/wordCount.csv')
stream = byline(stream)

data = []
count = 0

stream.on('data', (line) ->
  toks = line.split(/,/)
  data.push {text: toks[0], count: toks[1]}
).on('end', ->
  console.log 'DONE', data.length
  console.log 'processed ' + count
  db.save data, (err, res) ->
    console.log err if err
)


