# Blue Carbon Mobile

A phone gap application to allow iPad validation of a blue carbon data
layer, offline.

# Development

The main app is a web application, which is inside the www/ folder. It
downloads MBTiles (which are SQLite database of tiles) to serve the
offline tiles.  The JS is written in coffeescript, which can be
compiled/watched with this script:

    ./coffee_compile

## Migrations

The app uses an SQLite database to maintain local state when no internet
connection is available. A schema for the database is kept as a
Javascript object in `db/schema.js`. Run:

    node db/schema.js

Which will produce the SQL needed to be executed in your database. Soon
this will automatically create the database and create the appropriate
tables.

# Debugging

There's no easy way to say this. Debugging just sucks in phonegap.
Here's some methods that make it less terrible.

## Remote web inspector with weinre

There's no native debugger, but you can use weinre
(http://people.apache.org/~pmuellr/weinre/docs/latest/Home.html), the
remote web inspector. To do so, install it from NPM:

    sudo npm -g install weinre

Start a weinre server:

    weinre --boundHost -all-

Point the phonegap app to the remote debugger

    <script src="http://localhost:8080/target/target-script-min.js"></script>

Then simply hit http://localhost:8080/client/ to access the remote
inspector.

### Better remote console logging

Console logging is static and crazy unpredictable in phonegap by
default, so I added a weinre hook to wait for weinre to trigger the app
start, thereby allowing better console logging. To use, start the blue
carbon app (in index.html) with the 'waitForRemoteConsole' set to true:

    window.blueCarbonApp = new BlueCarbon.App({waitForRemoteConsole: true});

Then, connect your weinre console, and manually start the app from the
console:

    window.blueCarbonApp.start();

Enjoy proper console.log-ing

## Getting error stacks

The error handling and debugging is frankly infuriating in the iOS
simulator, but you can some useful error data by wrapping code in try
and catch blocks and interacting with the error object, like thus:

    try
      # Some code that's crashing
      5/0
    catch err
      # Do some stuff with the error object
      console.log err.stack alert "#{err.message} -> check the log for trace"
      window.err = err
