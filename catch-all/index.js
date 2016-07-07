var express = require('express')
var morgan = require('morgan')
var os = require('os')

var app = express()
var port = process.env.PORT || 3000

app.set('trust proxy', true)
app.use(morgan('combined'))

app.get('*', function(req, res, next) {
  res.send('Catch All Route: ' + os.hostname())
})

process.on('uncaughtException', logUncaughtError)
process.on('uncaughtRejection', logUncaughtError)

function logUncaughtError(err) {
  const timestamp = (new Date()).toUTCString()

  console.error(timestamp, 'uncaught error: ', err.message)
  console.error(err.stack)

  process.nextTick(function() { process.exit(1) })
}

var server = app.listen(port, function() {
  console.log('Listening on port:', server.address().port)
})
