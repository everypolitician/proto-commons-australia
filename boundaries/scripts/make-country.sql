WITH
	state_geoms AS
		(SELECT STATE_PID, ST_BUFFER(ST_COLLECT(geometry), 0) as geometry FROM "QLD_STATE_POLYGON_shp"
		UNION
		SELECT STATE_PID, ST_BUFFER(ST_COLLECT(geometry), 0) as geometry FROM "NSW_STATE_POLYGON_shp"
		UNION
		SELECT STATE_PID, ST_BUFFER(ST_COLLECT(geometry), 0) as geometry FROM "TAS_STATE_POLYGON_shp"
		UNION
		SELECT STATE_PID, ST_BUFFER(ST_COLLECT(geometry), 0) as geometry FROM "VIC_STATE_POLYGON_shp"
		UNION
		SELECT STATE_PID, ST_BUFFER(ST_COLLECT(geometry), 0) as geometry FROM "WA_STATE_POLYGON_shp"
		UNION
		SELECT STATE_PID, ST_BUFFER(ST_COLLECT(geometry), 0) as geometry FROM "NT_STATE_POLYGON_shp"
		UNION
		SELECT STATE_PID, ST_BUFFER(ST_COLLECT(geometry), 0) as geometry FROM "OT_STATE_POLYGON_shp"
		UNION
		SELECT STATE_PID, ST_BUFFER(ST_COLLECT(geometry), 0) as geometry FROM "SA_STATE_POLYGON_shp"
		UNION
		SELECT STATE_PID, ST_BUFFER(ST_COLLECT(geometry), 0) as geometry FROM "ACT_STATE_POLYGON_shp")
SELECT
	'Commonwealth of Australia',
	'country:au' as MS_FB,
	'Q408' as WIKIDATA,
	ST_Union(state_geoms.geometry) as geometry
FROM
	state_geoms

