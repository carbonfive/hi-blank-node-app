# A Blank Node Application

## Use this app as a new starting point or just for reference

## Customize it as needed

### Includes:
- express to start listening to http requests and or a socket.io events
- mocha-chai test framework with unit, integration and headless browser testing with [phantomjs](http://phantomjs.org/)
- coffee-script setup for development and for testing
- cakefile to run automated tests or to watch tests 
- stylus and nib for a light-weight css solution
- jade for rendering views
- an organized MVC+Services directory structure for quickly developing core functionality
- class loader mechanism to auto-load models and services
- routing configuration file (comming soon)
- support for sessions and cookies (comming soon!)
- connection to redis and/or mongoDB with test/dev/prod environments (comming soon!)
- an application class to easily configure the server (comming soon!)

### To Start Server:
````
npm install
npm start
````

### To Start Client:
````
browse to [ http://localhost:8888 ]
````

### To Execute Specs:
````
npm test
````
requires [phantomjs](http://phantomjs.org/), which is used for headless browser testing.

### To Install Phantom
````
brew update
brew install phantomjs
````

### &Xi; The MVP #1:
1. &Xi; feature 1
  * &Xi; /endpoint1/:param/path
2. &Xi; feature 2
  * &Xi; /endpoint2/:param/path
3. &Xi; feature 3
  * &Xi; /endpoint3/:param/path

### &Xi; The MVP #2:
1. &Xi; feature 1
  * &Xi; /endpoint1/:param/path
2. &Xi; feature 2
  * &Xi; /endpoint2/:param/path
3. &Xi; feature 3
  * &Xi; /endpoint3/:param/path

### &Xi; TO DO
````
+ deploy
+ write unit tests for models and services (see spec/server/models[services])
+ write integration tests for controllers (see spec/server/controllers)
+ write usage tests using phantomjs for views (see spec/client)
+ write MVP #1
+ write MVP #2
````

> **Key**

> &Xi; ToDo

> &hearts; In Progres

> &#10003; Complete
