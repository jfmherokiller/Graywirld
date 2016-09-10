

rem setup player struct
type Entity
	name as string
	x as integer
	y as integer
	z as integer
	savposx as integer
	savposy as integer
	savposz as integer
	room as integer
	
	hp as integer
	xp as integer
	xpcap as integer
	atk as integer
	def as integer
	mag as integer
	spd as integer
	
	deathflag as integer
	poisonflag as integer
	paralyzeflag as integer
	angerflag as integer
endtype
