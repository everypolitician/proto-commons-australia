#!/bin/bash

mkdir -p ../build/country

ogr2ogr \
	-sql @make-country.sql \
	-dialect sqlite \
	-t_srs EPSG:4326 \
	../build/country/country.shp \
	../source/state-boundaries.vrt \
	-lco ENCODING=UTF-8

ogr2ogr \
	-f "CSV" \
	../build/country/country.csv \
	../build/country/country.shp
