global.env = 'development'
global.debug = true
# DB:redis
global.redisURL =  process.env.REDIS_URL || 'redis://127.0.0.1:6379'
global.redisDBNumber = redisDevelopmentDB

global.mongoURL = process.env.MONGO_URL || "localhost:27017/#{appName}"
