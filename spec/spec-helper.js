global.localEnvironment = 'test' 

// default redis url and client
global.redisURL=  process.env.REDIS_URL || process.env.REDISTOGO_URL || 'redis://127.0.0.1:6379/'

global.chai       = require('chai');
global.Charlatan  = require('charlatan');

chaiHttp = require('chai-http');
chai.use(chaiHttp);

chaiSpies = require('chai-spies');
chai.use(chaiSpies);

chaiFactories = require('chai-factories')
chai.use(chaiFactories);

global.should = chai.should();
global.expect = chai.expect;
global.assert = chai.assert;

CAN_NOT_CONNECT = new Error("Could not connect to redis '#{redisURL}'");

// global.clearRedisTestEnv = (redis, msg, callback)->
//   redisTestDB = ALL_ORM_ENV_SETTINGS['test'].redis.dbNum
//   if redis.selected_db is redisTestDB
//     redis.dbsize (err, size)->
//       console.log "redis[#{redis.selected_db}]:", msg, "purging #{size} keys" if 0 < size
//       redis.flushdb (err, ok) ->
//         callback(null, ok)
//   else
//     callback(new Error "redis selected db ##{redis.selected_db} - Test Environment is db ##{redisTestDB}" ) 
