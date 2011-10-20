OSM Bright
==========

OSM Bright is a sensible starting point for quickly making beautiful maps based
on an OpenStreetMap database. It is written in the [Carto][] styling language
and can be opened as a project in [TileMill][].

The style is still a work in progress and you are encouraged to use the
[issue tracker][] to note missing features or problems with the current
implementation. 

[Carto]: http://github.com/mapbox/carto/
[TileMill]: http://tilemill.com/
[issue tracker]: http://github.com/developmentseed/osm-bright/issues/

Setup Instructions
------------------

### 1. Set up PostgreSQL & PostGIS ###

If you don't already, you need to have [PostgreSQL][] installed & running with
a [PostGIS][] database setup within it. See the [PostGIS documentation][1] for
full information on how to do this

[PostgreSQL]: http://postgresql.org/
[PostGIS]: http://postgis.refractions.net/
[1]: http://postgis.refractions.net/documentation/manual-1.5/

for 8.4 (ubuntu<=11.04) use the command
sudo apt-get install postgresql-8.4-postgis postgresql-contrib-8.4 postgis


### 2. Import OpenStreetMap data ###

You will need an OSM database extract in one of the following formats:

- .osm.pbf (binary; smallest & fastest)
- .osm.bz2 (compressed xml)
- .osm (xml)

this tutorial will assume your using the us-northeast.pbf which you can grab from <http://download.geofabrik.de/osm> (in north-america folder)

You can find appropriate data extracts for a variety of regions at
<http://download.geofabrik.de/osm> or <http://downloads.cloudmade.com>. See
also [the OSM wiki][2] for information about (very large) full-planet
downloads.

OSM Bright requires a PostGIS database imported with [ImpOSM][]. Support for
OSM2PGSQL is planned but not yet implemented.

to install imposm on ubuntu 11.04
sudo apt-get install build-essential python-dev protobuf-compiler \
                      libprotobuf-dev libtokyocabinet-dev python-psycopg2 \
                      libgeos-c1
sudo apt-get install python-pip
sudo pip install imposm

# once you have it installed run 
imposm-psqldb > create-db.sh #note the imposm site mis-spells this
# if your using postgres 9.1 this command won't work, use the file impism9-1.sh
# you may need to run sudo chmod 775 impism9-1.sh first then:
sudo su postgres #switch over to the postgres user
sh ./create-db.sh #or sh ./osm-bright/impism9-1.sh
# if you don't get any errors then 
exit
to import data you can run 
imposm --read --overwrite-cache --write --optimize --deploy-production-tables -m osm-bright/brightmapping.py -d osm us-northeast.osm.pbf
# to break that down: 
# --read reads the data and puts it into the cache
# --write takes the data in the cache and imports it into the database
# --optimize cleans stuff up
# --deploy-production-tables removes the new_ table prefixes, I usually don't do this now and instead run
# imposm --deploy-prodution-tables -d osm
# after I make sure it got into the database alright
# -m osm-bright/brightmapping.py tells it to use our custom mapping file
# -d osm tells it the name of the database, if you didn't use the defaults change this
# and last is the name of the file


### 3. Run configure.py ###

Included in with this style is a configuration script to help you adjust
parameters such as the database connection information and a few other things.

TODO: go on...
