SELECT
	SUBSTR(Electorate, 1, 1) || lower(SUBSTR(Electorate, 2)) as NAME,
	'country:au/state:sa' as MS_FB_PARE,
	'country:au/state:sa/shaed:' || replace(trim(lower(ELECTORATE)), ' ', '-') as MS_FB,
	ST_Buffer(geometry, 0) as geometry
FROM
	StateElectorates2018
