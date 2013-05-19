_ = require('underscore')._
async = require 'async'
db = require '../config/cradle'

Lookup =
  forWord: (word, cb) ->
    startKey = [word, {}]
    endKey = [word]

    db.view 'Word/look_up',
      descending: true
      limit: 30
      include_docs: true
      startkey: startKey
      endkey: endKey
    , (err, res) ->
      docs = (r.doc for r in res)
      console.log word,
        docs[0].text + "(" + docs[0].count + ")",
        docs[1].text + "(" + docs[1].count + ")",
        docs[2].text + "(" + docs[2].count + ")",
      cb null, docs[0].text

  forParagraph: (paragraph, cb) ->
    toks = paragraph.split(' ')
    makeFunction = (i, cb) ->
      (cb) ->
        Lookup.forWord toks[i], cb
    functions = []
    for tok,i in toks
      functions.push makeFunction(i, cb)


    async.parallel functions, (err, results) ->
      text = ''
      for res in results
        text += res + " "
      cb null, text

module.exports = Lookup
