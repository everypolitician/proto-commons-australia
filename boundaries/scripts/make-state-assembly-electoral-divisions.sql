WITH
	geoms AS
		(SELECT SE_PID, ST_COLLECT(geometry) as geometry FROM "QLD_STATE_ELECTORAL_POLYGON_shp" GROUP BY SE_PID
		UNION
		SELECT SE_PID, ST_COLLECT(geometry) as geometry FROM "NSW_STATE_ELECTORAL_POLYGON_shp" GROUP BY SE_PID
		UNION
		SELECT SE_PID, ST_COLLECT(geometry) as geometry FROM "TAS_STATE_ELECTORAL_POLYGON_shp" GROUP BY SE_PID
		UNION
		SELECT SE_PID, ST_COLLECT(geometry) as geometry FROM "VIC_STATE_ELECTORAL_POLYGON_shp" GROUP BY SE_PID
		UNION
		SELECT SE_PID, ST_COLLECT(geometry) as geometry FROM "WA_STATE_ELECTORAL_POLYGON_shp" GROUP BY SE_PID
		UNION
		SELECT SE_PID, ST_COLLECT(geometry) as geometry FROM "NT_STATE_ELECTORAL_POLYGON_shp" GROUP BY SE_PID
		UNION
		-- SELECT SE_PID, ST_COLLECT(geometry) as geometry FROM "OT_STATE_ELECTORAL_POLYGON_shp" GROUP BY SE_PID
		-- UNION
		SELECT SE_PID, ST_COLLECT(geometry) as geometry FROM "SA_STATE_ELECTORAL_POLYGON_shp" GROUP BY SE_PID
		UNION
		SELECT SE_PID, ST_COLLECT(geometry) as geometry FROM "ACT_STATE_ELECTORAL_POLYGON_shp" GROUP BY SE_PID),
	attribs AS
		(SELECT * FROM "QLD_STATE_ELECTORAL_shp"
		UNION
		SELECT * FROM "NSW_STATE_ELECTORAL_shp"
		UNION
		SELECT * FROM "TAS_STATE_ELECTORAL_shp"
		UNION
		SELECT * FROM "VIC_STATE_ELECTORAL_shp"
		UNION
		SELECT * FROM "WA_STATE_ELECTORAL_shp"
		UNION
		SELECT * FROM "NT_STATE_ELECTORAL_shp"
		UNION
		-- SELECT * FROM "OT_STATE_ELECTORAL_shp"
		-- UNION
		SELECT * FROM "SA_STATE_ELECTORAL_shp"
		UNION
		SELECT * FROM "ACT_STATE_ELECTORAL_shp"
	)
SELECT
	geoms.SE_PID,
	SUBSTR(attribs.NAME, 1, 1) || lower(SUBSTR(attribs.NAME, 2)) as NAME,
	attribs.DT_CREATE,
	auth.NAME_AUT AS TYPE,
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
		WHEN '1' THEN 'country:au/state:nsw/slaed:' || lower(attribs.SE_PID)
		WHEN '2' THEN 'country:au/state:vic/slaed:' || lower(attribs.SE_PID)
		WHEN '3' THEN 'country:au/state:qld/slaed:' || lower(attribs.SE_PID)
		WHEN '4' THEN 'country:au/state:sa/shaed:' || lower(attribs.SE_PID)
		WHEN '5' THEN 'country:au/state:wa/slaed:' || lower(attribs.SE_PID)
		WHEN '6' THEN 'country:au/state:tas/shaed:' || lower(attribs.SE_PID)
		WHEN '7' THEN 'country:au/state:nt/slaed:' || lower(attribs.SE_PID)
		WHEN '8' THEN 'country:au/state:act/slaed:' || lower(attribs.SE_PID)
		WHEN '9' THEN 'country:au/state:ot/slaed:' || lower(attribs.SE_PID)
	END AS MS_FB,
	ST_Buffer(geoms.geometry, 0) as geometry
FROM
	geoms
	JOIN attribs ON	geoms.SE_PID = attribs.SE_PID
	LEFT JOIN Authority_Code_STATE_ELECTORAL_CLASS_AUT_shp AS auth ON auth.CODE_AUT = attribs.SECL_CODE
WHERE
	attribs.EFF_END IS NULL
	AND attribs.DT_RETIRE IS NULL
	AND (attribs.SECL_CODE='2' OR attribs.SECL_CODE='1')
