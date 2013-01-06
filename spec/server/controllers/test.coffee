require (process.cwd() + '/config/application')

# see http://chaijs.com/plugins/chai-http
# see https://github.com/visionmedia/superagent

describe 'Controllers', ->
  before (done) ->
    done()

  it 'can test a controller', (done) =>
    chai.request(app).get('/').res (res)->
      (expect res).to.have.status(200);
      (expect res.text).to.not.be.empty
      done()
