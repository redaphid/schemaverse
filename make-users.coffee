Schemaverse = require './models/schemaverse'
async = require 'async'
_ = require 'lodash'
fs = require 'fs'
schema = new Schemaverse()
whatever = []
whatever.length = 999999

async.mapLimit whatever, 100, schema.createAccount, (error, results) =>
  console.error error.stack if error?
  console.log results
  results = _.compact results
  fs.writeFileSync 'users.json', JSON.stringify results, null, 2

#
# schema.postgresShit (error, result) =>
#   return console.error error.stack if error?
#   console.log result
