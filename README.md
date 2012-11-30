# Blue Carbon Mobile

A phone gap application to allow iPad validation of a blue carbon data layer, offline.

# Development

The main app is a web application, which is inside the www/ folder. It downloads MBTiles (which are SQLite database of tiles) to serve the offline tiles.
The JS is written in coffeescript, which can be compiled/watched with this script:

    ./coffee_compile
