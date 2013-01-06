global.p = global.puts = (items...)->
  return unless debug
  console.log "\n"
  console.log "---------------------"
  console.log items...
  console.log "====================="
  console.log "\n"
