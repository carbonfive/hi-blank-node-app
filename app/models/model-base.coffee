class ModelBase
  attributes: null

  constructor: (@attributes) ->
  id: ()-> @get('id')

  get: (attName) -> @attributes[attName] || null
  set: (attName, value) -> 
    return unless attName
    @attributes[attName] = value

  # subclasses can define an @service attribute in order to implement these
  save:       ()-> (@Service.save @)
  delete:     ()-> (@Service.delete @)
  update: (atts)-> (@Service.udpate @, atts)
  updateAttribute: (field, value)-> (@Service.udpateAttributes @, field, value)

  toJSON: () -> JSON.stringify @attributes
  toEvent: () -> @attributes

  emitTo: (channel) ->
    throw "No className defined" unless @className?
    if channel.manager?.settings?.transports? # send attributes when emitting over socket.io
      channel.emit @className(), @toEvent()
    else                                      # send model object when emitting through EventEmitter
      channel.emit @className(), @

  className: ()-> throw "@className() not defined:\n#{@toJSON()}"

module.exports = ModelBase
