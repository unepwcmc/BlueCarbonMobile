# Blue Carbon Mobile

A phone gap application to allow iPad validation of a blue carbon data layer, offline.

# Development

The main app is a web application, which is inside the www/ folder. It downloads MBTiles (which are SQLite database of tiles) to serve the offline tiles.
The JS is written in coffeescript, which can be compiled/watched with this script:

    ./coffee_compile

# Debugging

Debugging phonegap is unfortunately still a bit of a pain in the ass. There's no native debugger, but you can use weinre (http://people.apache.org/~pmuellr/weinre/docs/latest/Home.html), the remote web inspector. To do so, install it from NPM:

    sudo npm -g install weinre

Start a weinre server:

    weinre --boundHost -all-

Point the phonegap app to the remote debugger

    <script src="http://localhost:8080/target/target-script-min.js"></script>

Then simply hit http://localhost:8080/client/ to access the remote debugger
