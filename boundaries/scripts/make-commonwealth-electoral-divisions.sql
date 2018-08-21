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
		-- SELECT CE_PID, ST_COLLECT(geometry) as geometry FROM "OT_COMM_ELECTORAL_POLYGON_shp" GROUP BY CE_PID
		-- UNION
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
		-- SELECT * FROM "OT_COMM_ELECTORAL_shp"
		-- UNION
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
		WHEN '7' THEN 'country:au/state:nt'
		WHEN '8' THEN 'country:au/state:act'
		WHEN '9' THEN 'country:au/state:ot'
	END AS MS_FB_PARE,

	CASE attribs.STATE_PID
		WHEN '1' THEN 'country:au/state:nsw/ced:' || lower(attribs.CE_PID)
		WHEN '2' THEN 'country:au/state:vic/ced:' || lower(attribs.CE_PID)
		WHEN '3' THEN 'country:au/state:qld/ced:' || lower(attribs.CE_PID)
		WHEN '4' THEN 'country:au/state:sa/ced:' || lower(attribs.CE_PID)
		WHEN '5' THEN 'country:au/state:wa/ced:' || lower(attribs.CE_PID)
		WHEN '6' THEN 'country:au/state:tas/ced:' || lower(attribs.CE_PID)
		WHEN '7' THEN 'country:au/state:nt/ced:' || lower(attribs.CE_PID)
		WHEN '8' THEN 'country:au/state:act/ced:' || lower(attribs.CE_PID)
		WHEN '9' THEN 'country:au/state:ot/ced:' || lower(attribs.CE_PID)
	END AS MS_FB,
	ST_Buffer(geoms.geometry, 0) as geometry
FROM
	geoms
	JOIN
    attribs
ON
	geoms.CE_PID = attribs.CE_PID
