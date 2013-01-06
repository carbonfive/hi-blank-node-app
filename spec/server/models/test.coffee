require (process.cwd() + '/config/application')

describe 'Models', ->
  before (done) ->
    done()

  it 'can test a model', (done) =>
    (expect 1).to.be.ok
    done()
