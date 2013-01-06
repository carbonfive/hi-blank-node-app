fs = require 'fs'
{print} = require 'sys'
{spawn} = require 'child_process'


defaultReportFormat = 'spec'
defaultSpecTimeout = 2000 # ms


# task 'spec:watch', 'Run the specs whenever the code changes', ->
#   mocha = spawn './node_modules/.bin/mocha', ['-w',  '-t', '5000', '-R', 'min', '--compilers', 'coffee:coffee-script', '--require', 'spec/spec-helper', '--colors', 'spec/lib'], { cwd: process.cwd(), env: process.env }
#   mocha.stderr.on 'data', (data) ->
#     process.stderr.write data.toString()
#   mocha.stdout.on 'data', (data) =>
#     print data.toString()
#   mocha.on 'exit', (code) ->
#     callback?() if code is 0

task 'spec',              -> spawnMocha path: 'spec'

task 'spec:client',       -> spawnMocha path: 'spec/client'

task 'spec:server',       -> spawnMocha path: 'spec/server'

task 'spec:models',       -> spawnMocha path: 'spec/server/models'

task 'spec:services',     -> spawnMocha path: 'spec/server/services'

task 'spec:controllers',  -> spawnMocha path: 'spec/server/controllers'

task 'spec:watch', -> spawnMocha path: 'spec', format: 'min', watch: true

spawnMocha = ({path, format, timeout, watch}, callback) ->
  format ?= defaultReportFormat
  timeout ?= defaultSpecTimeout
  mochaOpts = ['-t', timeout, '-R', format, 'recursive', '--compilers', 'coffee:coffee-script', '--require', './spec/spec-helper', '--colors', path]
  mochaOpts = ['-w'].concat mochaOpts if watch?
  mochaArgs = { cwd: process.cwd(), env: process.env }
  mocha = spawn './node_modules/.bin/mocha', mochaOpts, mochaArgs
  mocha.stderr.on 'data', (data) -> process.stderr.write data.toString()
  mocha.stdout.on 'data', (data) -> print data.toString()
  mocha.on 'exit', (code) -> callback?() if code is 0

