controllers = require rootPath.controllers

# set appData javascript variable for all responses (using express-expose)
app.all '*', (req, res, next) -> 
  res.expose({}, 'appData'); next()
  # res.expose ()->
  #   notify = ()-> alert('this will execute right away :D')
  #   notify()

#homepage
app.get '/', controllers.home.index
