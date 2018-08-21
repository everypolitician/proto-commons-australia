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
		SELECT STATE_PID, ST_BUFFER(ST_COLLECT(geometry), 0) as geometry FROM "ACT_STATE_POLYGON_shp"),
	state_attribs AS
		(SELECT a.*, 'Q36074' AS WIKIDATA FROM "QLD_STATE_shp" AS a
		UNION
		SELECT a.*, 'Q3224' AS WIKIDATA FROM "NSW_STATE_shp" AS a
		UNION
		SELECT a.*, 'Q34366' AS WIKIDATA FROM "TAS_STATE_shp" AS a
		UNION
		SELECT a.*, 'Q36687' AS WIKIDATA FROM "VIC_STATE_shp" AS a
		UNION
		SELECT a.*, 'Q3206' AS WIKIDATA FROM "WA_STATE_shp" AS a
		UNION
		SELECT a.*, 'Q3235' AS WIKIDATA FROM "NT_STATE_shp" AS a
		UNION
		SELECT a.*, '' AS WIKIDATA FROM "OT_STATE_shp" AS a
		UNION
		SELECT a.*, 'Q35715' AS WIKIDATA FROM "SA_STATE_shp" AS a
		UNION
		SELECT a.*, 'Q3258' AS WIKIDATA FROM "ACT_STATE_shp" AS a
	)
SELECT
	-- *
	state_geoms.STATE_PID,
	state_attribs.STATE_NAME,
	'country:au' AS MS_FB_PARE,
	'country:au/state:' || lower(state_attribs.ST_ABBREV) AS MS_FB,
	state_attribs.WIKIDATA,
	state_geoms.geometry as geometry
	-- ST_COLLECT(state_geoms.geometry) as geometry
	-- ST_BUFFER(state_geoms.geometry) as geometry
FROM
	state_geoms
	JOIN
    state_attribs
ON
	state_geoms.STATE_PID = state_attribs.STATE_PID
