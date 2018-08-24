#!/bin/bash

mkdir -p ../build/wards

ogr2ogr \
	-sql @make-wards.sql \
	-dialect sqlite \
	-t_srs EPSG:4326 \
	../build/wards/wards-ur.shp \
	../source/wards.vrt \
	-lco ENCODING=UTF-8

ogr2ogr \
	-f "CSV" \
	../build/wards/wards-ur.csv \
	../build/wards/wards-ur.shp
