Schemaverse = require './models/schemaverse'
async       = require 'async'
_           = require 'lodash'
fs          = require 'fs'

users = JSON.parse fs.readFileSync './users.json'
schema = new Schemaverse()

schema.postgresShit
