require (process.cwd() + '/config/application')

describe 'Services', ->
  before (done) ->
    done()

  it 'can test a service', (done) =>
    (expect 1).to.be.ok
    done()
