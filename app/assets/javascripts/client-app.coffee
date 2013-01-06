String.prototype.trim ||= ()->
  @replace /^\s+|\s+$/g, ""

String.prototype.tokens ||= (delim) ->
  list = @split(delim)
  list = (item.trim() for item in list)

socket = io.connect()
socket.on 'connect', ->
  socket.on 'biz', (bizData)-> console.log bizData; app.yelpBizListDisplay.addBiz bizData;
  socket.on 'search-results', (searchResults)-> console.log searchResults; app.yelpBizListDisplay.addBizList searchResults.businesses;

window.loadUserTweets = (screen_name) -> socket.emit 'user-tweets', screen_name #'GGCvegas'
window.loadStreamerTweets = (screen_name) -> socket.emit 'streamer-tweets', screen_name # 'FTMUSTXAUS'

window.ClientApp = class ClientApp
  @views:{}
  @adapters: {}
  
# backbone
$ ->
  _.templateSettings = {
    interpolate : /\{\{(.+?)\}\}/g
  };

  window.YelpBiz = Backbone.Model.extend()

  window.YelpBizList = Backbone.Collection.extend
    model: YelpBiz

  window.YelpBizDisplay = Backbone.View.extend
    el: "#yelp-template"

    initialize: () ->
      @template = _.template @$el.html();

    render: () ->
      @el = @template @model

  window.YelpBizListDisplay = Backbone.View.extend
    el: '#biz-list'
    initialize: () ->
      @collection = new YelpBizList
      ($ 'body').bind 'biz', (ev, bizData) => @collection.add new YelpBiz bizData
      @collection.on 'add', @addBiz, @
      @render

    addBiz: (biz) ->
      yelpBizDisplay = new YelpBizDisplay
        model: biz
      x = yelpBizDisplay.render()
      $x = ($ x)
      ($ '#biz-list').prepend $x
      $x.slideDown('slow')

    addBizList: (bizList) -> @addBiz(biz) for biz in bizList

    render: () ->

  window.YelpApp = class YelpApp
    constructor: () ->
      @yelpBizListDisplay = new YelpBizListDisplay
      bizList = if appData.bizList? then appData.bizList else if appData.biz? then [ appData.biz ] else if appData.searchResults? then appData.searchResults.businesses else []
      @yelpBizListDisplay.addBizList(bizList)

      $('input.yelpId').keyup (event)->
        yelpIds = $(this).val()
        yelpIds = yelpIds.tokens(',')
        socket.emit 'multi-biz', '77', yelpIds if 13 is event.which
      $('input.name').keyup (event)->
        socket.emit 'name', $(this).val(), $('input.location').val() if 13 is event.which
      $('input.search').keyup (event)->
        socket.emit 'search',  $(this).val(), $('input.location').val() if 13 is event.which
      $('input.location').keyup (event)->
        $('input.search').focus() if 13 is event.which

    render: () ->
      @yelpBizListDisplay.render()

  window.app = new YelpApp
  app.render()
