global.env = 'production'
global.debug = false

# DB:redis
global.redisURL = process.env.REDISTOGO_URL || process.env.REDIS_URL
global.redisDBNumber = redisProductionDB

# DB:mongo
global.mongoURL = process.env.MONGOLAB_URI || process.env.MONGO_URL
