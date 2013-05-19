express = require("express")
routes = require("./routes")
app = module.exports = express.createServer()
db = require "./config/cradle"

Lookup = require "./tools/lookup"

# Configuration
app.configure ->
  app.set "views", __dirname + "/views"
  app.set "view engine", "coffee"
  app.register '.coffee', require('coffeekup').adapters.express
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(__dirname + "/public")

app.configure "development", ->
  app.use express.errorHandler
    dumpExceptions: true
    showStack: true


app.configure "production", ->
  app.use express.errorHandler()


# Routes
app.get "/", routes.index

app.post "/gen", (req, res) ->
  console.log req.body.text
  Lookup.forParagraph req.body.text, (err, text) ->
    res.send text: text

app.listen 3001
console.log "Express server listening on port %d in %s mode", app.address().port, app.settings.env
