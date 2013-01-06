app = require (process.cwd() + '/config/application')
http        = (require 'http')
httpServer  = http.createServer app
httpServer.listen (app.get 'port'), -> 
  console.log "Express server listening on port #{app.get 'port'}"


phantom = require 'phantom'

describe 'client', ->
  @page = null
  @browser = null

  before (done) =>
    phantom.create (ph) =>
      console.log 'got a browser'
      @browser = ph
      @browser.createPage (page) =>
        console.log 'got a page'
        @page = page
        done()

  after (done) =>
    @browser.exit()
    done()

  describe 'GET /', =>
    before (done) =>
      @page.open "http://localhost:8888", (status) =>
        (expect status).to.equal 'success'
        done()

    after (done) =>
      done()

    it 'has a page title', (done) =>
      @page.evaluate (-> document.title), (result) =>
        (expect result).to.equal appName
        done()

    it 'has a valid heading', (done) =>
      @page.evaluate (-> $('.app').html()), (result) =>
        (expect result).to.equal "Hello #{appName}"
        done()
