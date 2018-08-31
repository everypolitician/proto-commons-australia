#!/bin/bash

mkdir -p ../build/commonwealth-electoral-divisions

ogr2ogr \
	-sql @make-commonwealth-electoral-divisions.sql \
	-dialect sqlite \
	-t_srs EPSG:4326 \
	../build/commonwealth-electoral-divisions/commonwealth-electoral-divisions-ur.shp \
	../source/commonwealth-electoral-boundaries.vrt \
	-lco ENCODING=UTF-8

ogr2ogr \
	-f "CSV" \
	../build/commonwealth-electoral-divisions/commonwealth-electoral-divisions-ur.csv \
	../build/commonwealth-electoral-divisions/commonwealth-electoral-divisions-ur.shp
