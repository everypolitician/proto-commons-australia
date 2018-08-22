#!/bin/bash

mkdir -p ../build/state-assembly-electoral-divisions

ogr2ogr \
	-sql @make-state-assembly-electoral-divisions.sql \
	-dialect sqlite \
	-t_srs EPSG:4326 \
	../build/state-assembly-electoral-divisions/state-assembly-electoral-divisions-ur.shp \
	../source/state-electoral-boundaries.vrt \
	-lco ENCODING=UTF-8

ogr2ogr \
	-f "CSV" \
	../build/state-assembly-electoral-divisions/state-assembly-electoral-divisions-ur.csv \
	../build/state-assembly-electoral-divisions/state-assembly-electoral-divisions-ur.shp
