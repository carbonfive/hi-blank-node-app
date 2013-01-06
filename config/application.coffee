# configure an express app: code structure and environment (test, development, production)

global.appName = 'BlankNodeApp' # appName follows variable naming conventions (no spaces, etc) 

global.node_env = process.env.NODE_ENV || global.localEnvironment || 'test'
console.log "#{appName} running in  #{node_env} environment"

path          = (require 'path')
express       = (require 'express')
expose        = (require 'express-expose')
connectAssets = (require 'connect-assets')

# export the app, and make it available globally
module.exports = global.app = express()

rootDir = (path.normalize __dirname + '/..')

# sessionStore = new express.session.MemoryStore;
# app.use express.cookieParser()
# app.use express.cookieParser('your secret here')
# app.use(express.session({ secret: 'foodtrucko', store: sessionStore }));

assetsPipeline = connectAssets src: 'app/assets'
css.root = 'stylesheets'
js.root = 'javascripts'

console.log rootDir
app.configure ->
  app.set 'port', process.env.PORT || process.env.VMC_APP_PORT || 8888
  app.set 'views', (rootDir + '/app/views')
  app.set 'view engine', 'jade'
  app.use express.favicon()
  app.use express.logger('dev')
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(path.join(rootDir, 'public'))
  app.use assetsPipeline

app.configure 'production', ->
  app.use express.errorHandler()
app.configure 'development', ->
  app.use (express.errorHandler dumpExceptions: true, showStack: true )

fs = (require 'fs')

# application paths
global.rootPath = {}
rootDir = process.cwd()
rootPath.path =         (rootDir + '/')
rootPath.db =           (rootPath.path + 'db/')
rootPath.lib =          (rootPath.path + 'lib/')
rootPath.config =       (rootPath.path + 'config/')
rootPath.public =       (rootPath.path + 'public/')
rootPath.extentions =   (rootPath.lib + 'extentions/')

rootPath.app =          (rootPath.path + 'app/')
rootPath.utils =        (rootPath.app + 'utils/')
rootPath.assets =       (rootPath.app + 'assets/')
rootPath.models =       (rootPath.app + 'models/')
rootPath.controllers =  (rootPath.app + 'controllers/')
rootPath.services =     (rootPath.app + 'services/')

global.requireModuleInFile = (path, filename, config={})->
  globalize = if config.globalize? then config.globalize else true
  filePath = path+filename
  try
    if globalize and String.prototype.toClassName
      className = filename.toClassName()
      clazz = require filePath    # if anything is exported, assume that it is a Class
      global[className] = clazz   # make the class available globally
    else
      require filePath
  catch exception
    console.log ""
    console.log "!! could not load #{filename} from #{path}"
    throw exception

global.requireModulesInDirectory = (path, config={})->
  globalize = if config.globalize? then config.globalize else true
  (requireModuleInFile path, f, globalize) for f in fs.readdirSync(path)

# load some usefull stuff
requireModulesInDirectory rootPath.extentions, globalize: false
requireModulesInDirectory rootPath.utils
# global.Util = (require rootPath.utils + 'util')
# global.puts = (require rootPath.utils + 'puts')
# global.log  = (require rootPath.utils + 'log')

# set application configurations
global.redisURL = null # runtime environment would override this, if using redis
global.redisDBNumber = 99999 # runtime environment would also override this to one of the DB numbers below:
global.redisTestDB = 2
global.redisDevelopmentDB = 1
global.redisProductionDB = 0

global.mongoURL = null


# load runtime environment
require "./environments/#{node_env}"

# connect to mondoDB
if mongoURL
  global.mongoDB = (require 'mongoskin').db mongoURL
  # +++ create database if it does not exists?

# connect to redis
if redisURL
  global.redis = require('redis-url').connect(redisURL)
  redis.on 'connect', =>
    redis.send_anyways = true
    console.log "redis: connection established"
    redis.select redisDBNumber, (err, val) => 
      redis.send_anyways = false
      redis.selectedDB = redisDBNumber
      console.log "redis: selected DB ##{redisDBNumber} for #{env}"
      redis.emit 'db-select', redisDBNumber
      unless debug
        redis.keys '*', (err, keys)->
          console.log "redis: #{keys.length} keys present in DB ##{redisDBNumber} "

# load classes
require rootPath.models
require rootPath.services

# Load app routes
require './routes'

