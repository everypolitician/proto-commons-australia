#!/bin/bash

mkdir -p ../build/local-government-areas

ogr2ogr \
	-sql @make-local-government-areas.sql \
	-dialect sqlite \
	-t_srs EPSG:4326 \
	../build/local-government-areas/local-government-areas-ur.shp \
	../source/local-government-areas.vrt \
	-lco ENCODING=UTF-8

ogr2ogr \
	-f "CSV" \
	../build/local-government-areas/local-government-areas-ur.csv \
	../build/local-government-areas/local-government-areas-ur.shp
