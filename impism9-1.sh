# run this as postgres user, eg:
# imposm-pgsql > create_db.sh; sudo su postgres; sh ./create_db.sh
set -xe
createuser --no-superuser --no-createrole --createdb osm
createdb -E UTF8 -O osm osm
#createlang plpgsql osm
psql -d osm -f /usr/share/postgresql/9.1/contrib/postgis-1.5/postgis.sql 	
psql -d osm -f /usr/share/postgresql/9.1/contrib/postgis-1.5/spatial_ref_sys.sql 
psql -d osm -f /usr/local/lib/python2.7/dist-packages/imposm/900913.sql
echo "ALTER TABLE geometry_columns OWNER TO osm; ALTER TABLE spatial_ref_sys OWNER TO osm;" | psql -d osm
echo "ALTER USER osm WITH PASSWORD 'osm';" |psql -d osm
echo "host	osm	osm	127.0.0.1/32	md5" >> /etc/postgresql/9.1/main/pg_hba.conf 		# <- CHANGE THIS PATH
set +x
echo "Done. Don't forget to restart postgresql!"
