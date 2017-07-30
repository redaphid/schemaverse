_       = require 'lodash'
Chance  = require 'chance'
request = require 'request'

class Schemaverse
  constructor: ->
    @chance = new Chance()

  postgresShit: ({username, password}, callback) =>
    { Client } = require 'pg'

    client = new Client
      host: 'db.schemaverse.com'
      database: 'schemaverse'
      user: username
      password: password

    console.log "about to connect #{username}:#{password}"
    client.connect (error) =>
      console.error error.stack if error?
      return callback() if error?
      console.log 'connected'
      client.query 'SELECT GET_PLAYER_ID(SESSION_USER);', (error, results) =>
        return callback() if error?
        callback null, results


  postCreateAccount: ({username, password}, callback) =>
    #-H 'Cookie: PHPSESSID=4vcdp0c7q5t45p0m98f16h2gp4'
    #-H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: en-US,en;q=0.8' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36' -H 'Accept: application/json, text/javascript, */*; q=0.01' -H 'Referer: https://schemaverse.com/tutorial/tutorial.php?page=Registration' -H 'X-Requested-With: XMLHttpRequest' -H 'Connection: keep-alive' --compressed
    options =
      url: "https://schemaverse.com/tw/command.php"
      rejectUnauthorized: false
      qs:
        cmd: 'register'
        username: username
        password: password
      headers:
        "Cookie": "PHPSESSID=rs8slqde5mr0f8jio7nuojiul2"
        "Origin": "https://schemaverse.com"
        "Accept-Encoding": "gzip, deflate, br"
        "Accept-Language": "en-US,en;q=0.8"
        "Upgrade-Insecure-Requests": "1"
        "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36"
        "Content-Type": "application/x-www-form-urlencoded"
        "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8"
        "Cache-Control": "max-age=0"
        "Referer": "https://schemaverse.com/tw/index.php"
        "Connection": "keep-alive"
        "DNT": "1"

    request.post options, (error, response) =>
      return callback() if error?
      return callback() if response.statusCode != 200
      console.log {username, password}
      callback null, {username, password}

  createAccount: (nothing, callback) =>
    username = @chance.name().split(' ').join('').toLowerCase()
    password = _.random(99999,9999999999999999).toString '16'
    @postCreateAccount {username, password}, callback


module.exports = Schemaverse
