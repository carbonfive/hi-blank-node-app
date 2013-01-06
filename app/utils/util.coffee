class Util
  @uid: (options)-> 
    numerical = options['numerical'] || false
    base = numerical ? 10 : 16
    S4 = -> 
      num = (Util.random 0x10000)
      if numerical then num.toString() else num.toString(16)
    guid = S4() + S4() + S4() + S4()
    if numerical then (parseInt guid) else guid

  @random: (mask = 0x1000)->
    (Math.floor Math.random() * mask)

  @aMoment = (callback)->
    fn = -> (process.nextTick callback)
    setTimeout fn, 8 # wait a few ms

  @delay = (ms, fn) -> setTimeout fn, ms


module.exports = Util