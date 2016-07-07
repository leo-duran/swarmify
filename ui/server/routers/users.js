const express = require('express')
const router = express.Router()
const os = require('os')

const users = [{
  id: 1,
  name: 'Michael Kushlan'
}, {
  id: 2,
  name: 'Dane Thurber'
}, {
  id: 3,
  name: 'Maureen Botoman'
}, {
  id: 4,
  name: 'Jonathan Davis'
}, {
  id: 5,
  name: 'Leo Duran'
}]

router.get(`/users`, (req, res) => {
  const payload = {
    hostname: os.hostname(),
    collection: users
  }

  res
    .status(200)
    .json(payload)
})

module.exports = router
