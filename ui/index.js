const port = process.env.PORT || 3000
const app = require('./server')

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
