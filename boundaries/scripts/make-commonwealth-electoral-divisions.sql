WITH
	geoms AS
		(SELECT CE_PID, ST_COLLECT(geometry) as geometry FROM "QLD_COMM_ELECTORAL_POLYGON_shp" GROUP BY CE_PID
		UNION
		SELECT CE_PID, ST_COLLECT(geometry) as geometry FROM "NSW_COMM_ELECTORAL_POLYGON_shp" GROUP BY CE_PID
		UNION
		SELECT CE_PID, ST_COLLECT(geometry) as geometry FROM "TAS_COMM_ELECTORAL_POLYGON_shp" GROUP BY CE_PID
		UNION
		SELECT CE_PID, ST_COLLECT(geometry) as geometry FROM "VIC_COMM_ELECTORAL_POLYGON_shp" GROUP BY CE_PID
		UNION
		SELECT CE_PID, ST_COLLECT(geometry) as geometry FROM "WA_COMM_ELECTORAL_POLYGON_shp" GROUP BY CE_PID
		UNION
		SELECT CE_PID, ST_COLLECT(geometry) as geometry FROM "NT_COMM_ELECTORAL_POLYGON_shp" GROUP BY CE_PID
		UNION
		SELECT CE_PID, ST_COLLECT(geometry) as geometry FROM "SA_COMM_ELECTORAL_POLYGON_shp" GROUP BY CE_PID
		UNION
		SELECT CE_PID, ST_COLLECT(geometry) as geometry FROM "ACT_COMM_ELECTORAL_POLYGON_shp" GROUP BY CE_PID),
	attribs AS
		(SELECT * FROM "QLD_COMM_ELECTORAL_shp"
		UNION
		SELECT * FROM "NSW_COMM_ELECTORAL_shp"
		UNION
		SELECT * FROM "TAS_COMM_ELECTORAL_shp"
		UNION
		SELECT * FROM "VIC_COMM_ELECTORAL_shp"
		UNION
		SELECT * FROM "WA_COMM_ELECTORAL_shp"
		UNION
		SELECT * FROM "NT_COMM_ELECTORAL_shp"
		UNION
		SELECT * FROM "SA_COMM_ELECTORAL_shp"
		UNION
		SELECT * FROM "ACT_COMM_ELECTORAL_shp"
	)
SELECT
	geoms.CE_PID,
	SUBSTR(attribs.NAME, 1, 1) || lower(SUBSTR(attribs.NAME, 2)) as NAME,
	attribs.DT_CREATE,
	attribs.REDISTYEAR,
	CASE attribs.STATE_PID
		WHEN '1' THEN 'country:au/state:nsw'
		WHEN '2' THEN 'country:au/state:vic'
		WHEN '3' THEN 'country:au/state:qld'
		WHEN '4' THEN 'country:au/state:sa'
		WHEN '5' THEN 'country:au/state:wa'
		WHEN '6' THEN 'country:au/state:tas'
		WHEN '7' THEN 'country:au/territory:nt'
		WHEN '8' THEN 'country:au/territory:act'
	END AS MS_FB_PARE,

-- This field will need to be mannually modified to replace spaces, and apostrophes and generally match OCD ids.
	CASE attribs.STATE_PID
		WHEN '1' THEN 'country:au/state:nsw/federal_electorate:' || lower(attribs.NAME)
		WHEN '2' THEN 'country:au/state:vic/federal_electorate:' || lower(attribs.NAME)
		WHEN '3' THEN 'country:au/state:qld/federal_electorate:' || lower(attribs.NAME)
		WHEN '4' THEN 'country:au/state:sa/federal_electorate:' || lower(attribs.NAME)
		WHEN '5' THEN 'country:au/state:wa/federal_electorate:' || lower(attribs.NAME)
		WHEN '6' THEN 'country:au/state:tas/federal_electorate:' || lower(attribs.NAME)
		WHEN '7' THEN 'country:au/territory:nt/federal_electorate:' || lower(attribs.NAME)
		WHEN '8' THEN 'country:au/territory:act/federal_electorate:' || lower(attribs.NAME)
	END AS MS_FB,
	ST_Buffer(geoms.geometry, 0) as geometry
FROM
	geoms
	JOIN
    attribs
ON
	geoms.CE_PID = attribs.CE_PID
