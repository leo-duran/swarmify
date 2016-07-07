const express = require('express')
const morgan = require('morgan')
const os = require('os')

const mountPoint = process.env.MOUNT_POINT || '/ui'

var app = express()

app.set('trust proxy', true)
app.use(morgan('combined'))

app.get(mountPoint, (req, res) => {
  res.send(os.hostname())
})

module.exports = app
