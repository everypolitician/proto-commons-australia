#!/usr/bin/env bash


rm ../build/state-assembly-electoral-divisions/sa-2018-eds-ur.*

ogr2ogr \
	-t_srs EPSG:4326 \
	-sql @south-australia-2018-update.sql \
	-dialect sqlite \
	../build/state-assembly-electoral-divisions/sa-2018-eds-ur.shp \
	/vsizip//vsicurl/http://www.dptiapps.com.au/dataportal/StateElectorates2018_shp.zip \
	-lco ENCODING=UTF-8


ogr2ogr \
	-f "CSV" \
	../build/state-assembly-electoral-divisions/sa-2018-eds-ur.csv \
	../build/state-assembly-electoral-divisions/sa-2018-eds-ur.shp \
