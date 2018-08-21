#!/bin/bash

mkdir -p ../build/states

ogr2ogr \
	-sql @make-states.sql \
	-dialect sqlite \
	-t_srs EPSG:4326 \
	../build/states/states.shp \
	../source/state-boundaries.vrt \
	-lco ENCODING=UTF-8

ogr2ogr \
	-f "CSV" \
	../build/states/states.csv \
	../build/states/states.shp
