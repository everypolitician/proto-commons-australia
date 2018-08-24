WITH
	geoms AS
		(SELECT LGA_PID, ST_COLLECT(geometry) as geometry FROM "QLD_LGA_POLYGON_shp" GROUP BY LGA_PID
		UNION
		SELECT LGA_PID, ST_COLLECT(geometry) as geometry FROM "NSW_LGA_POLYGON_shp" GROUP BY LGA_PID
		UNION
		SELECT LGA_PID, ST_COLLECT(geometry) as geometry FROM "VIC_LGA_POLYGON_shp" GROUP BY LGA_PID
		UNION
		SELECT LGA_PID, ST_COLLECT(geometry) as geometry FROM "WA_LGA_POLYGON_shp" GROUP BY LGA_PID
		UNION
		SELECT LGA_PID, ST_COLLECT(geometry) as geometry FROM "SA_LGA_POLYGON_shp" GROUP BY LGA_PID
	),
	attribs AS
		(SELECT * FROM "QLD_LGA_shp"
		UNION
		SELECT * FROM "NSW_LGA_shp"
		UNION
		SELECT * FROM "VIC_LGA_shp"
		UNION
		SELECT * FROM "WA_LGA_shp"
		UNION
		SELECT * FROM "SA_LGA_shp"
	)
SELECT
	geoms.LGA_PID,
	SUBSTR(attribs.ABB_NAME, 1, 1) || lower(SUBSTR(attribs.ABB_NAME, 2)) as NAME,
	attribs.DT_CREATE,
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
		WHEN '1' THEN 'country:au/state:nsw/lga:' || lower(attribs.LGA_PID)
		WHEN '2' THEN 'country:au/state:vic/lga:' || lower(attribs.LGA_PID)
		WHEN '3' THEN 'country:au/state:qld/lga:' || lower(attribs.LGA_PID)
		WHEN '4' THEN 'country:au/state:sa/lga:' || lower(attribs.LGA_PID)
		WHEN '5' THEN 'country:au/state:wa/lga:' || lower(attribs.LGA_PID)
		WHEN '6' THEN 'country:au/state:tas/lga:' || lower(attribs.LGA_PID)
		WHEN '7' THEN 'country:au/state:nt/lga:' || lower(attribs.LGA_PID)
		WHEN '8' THEN 'country:au/state:act/lga:' || lower(attribs.LGA_PID)
		WHEN '9' THEN 'country:au/state:ot/lga:' || lower(attribs.LGA_PID)
	END AS MS_FB,
	ST_Buffer(geoms.geometry, 0) as geometry
FROM
	geoms
	JOIN attribs ON	geoms.LGA_PID = attribs.LGA_PID
WHERE
	attribs.DT_RETIRE IS NULL
	AND attribs.LGA_PID IN (
		'NSW175',
		'NSW177',
		'NSW180',
		'NSW181',
		'NSW196',
		'NSW200',
		'NSW206',
		'NSW207',
		'NSW212',
		'NSW213',
		'NSW216',
		'NSW217',
		'NSW229',
		'NSW232',
		'NSW234',
		'NSW258',
		'NSW264',
		'NSW268',
		'NSW272',
		'NSW275',
		'NSW282',
		'NSW283',
		'NSW294',
		'NSW295',
		'NSW298',
		'NSW306',
		'NSW310',
		'NSW314',
		'NSW315',
		'NSW325',
		'NSW329',
		'NSW331',
		'NSW332',
		'NSW335',
		'QLD21',
		'QLD295',
		'QLD319',
		'QLD63',
		'SA101',
		'SA102',
		'SA105',
		'SA107',
		'SA154',
		'SA73',
		'SA74',
		'SA75',
		'SA76',
		'SA78',
		'SA81',
		'SA82',
		'SA83',
		'SA85',
		'SA90',
		'SA91',
		'SA92',
		'SA93',
		'SA98',
		'VIC121',
		'VIC131',
		'VIC132',
		'VIC177',
		'VIC182',
		'VIC188',
		'VIC189',
		'VIC195',
		'VIC196',
		'VIC201',
		'VIC202',
		'VIC203',
		'VIC205',
		'VIC208',
		'VIC210',
		'VIC226',
		'VIC234',
		'VIC235',
		'WA307',
		'WA308',
		'WA309',
		'WA310',
		'WA311',
		'WA312',
		'WA313',
		'WA314',
		'WA315',
		'WA316',
		'WA317',
		'WA318',
		'WA319',
		'WA320',
		'WA321',
		'WA334',
		'WA360',
		'WA368',
		'WA369',
		'WA370',
		'WA371',
		'WA373',
		'WA374',
		'WA375',
		'WA376',
		'WA377',
		'WA416',
		'WA423',
		'WA425',
		'WA427'
	)
