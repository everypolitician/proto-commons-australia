#!/bin/bash

mkdir -p ../build/state-council-electoral-divisions

ogr2ogr \
	-sql @make-state-council-electoral-divisions.sql \
	-dialect sqlite \
	-t_srs EPSG:4326 \
	../build/state-council-electoral-divisions/state-council-electoral-divisions-ur.shp \
	../source/state-electoral-boundaries.vrt \
	-lco ENCODING=UTF-8

ogr2ogr \
	-f "CSV" \
	../build/state-council-electoral-divisions/state-council-electoral-divisions-ur.csv \
	../build/state-council-electoral-divisions/state-council-electoral-divisions-ur.shp
