app = (require '../config/application')

# create the http server and start listening
http        = (require 'http')
httpServer  = http.createServer app
httpServer.listen (app.get 'port'), -> 
  console.log "Express server listening on port #{app.get 'port'}"

# create the socket server and start listening
socketIO = (require 'socket.io')
io = socketIO.listen httpServer
io.configure ->
  io.set "transports", ["xhr-polling"]
  (io.set "polling duration", 10)
  (io.set "log level", 2) 
# Heroku doesn't yet allow use of WebSockets: setup long polling instead.
# https://devcenter.heroku.com/articles/using-socket-io-with-node-js-on-heroku
# https://github.com/LearnBoost/Socket.IO/wiki/Configuring-Socket.IO

io.sockets.on 'connection', (socket)-> 
  console.log 'socket.io connected'

  socket.on 'greetings', (sessionId, name)->
    socket.emit 'response', "hi #{name}"
