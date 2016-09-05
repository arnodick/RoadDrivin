local function make(tw,th,gw,gh)
	--game initialization stuff (just boring stuff you need to maek Video Game)
	love.math.setRandomSeed(1)
	love.keyboard.setKeyRepeat(true)
	DebugMode=false
	DebugList={}
	Actors={}
	
	--global variables
	State=3
	Timer=0
	Pause=0
	
	Palette={}
	table.insert(Palette,{0,0,0})
	table.insert(Palette,{32,51,123})
	table.insert(Palette,{126,37,83})
	table.insert(Palette,{0,144,61})
	table.insert(Palette,{171,82,54})
	table.insert(Palette,{52,54,53})
	table.insert(Palette,{194,195,199})
	table.insert(Palette,{255,241,232})
	table.insert(Palette,{255,0,77})
	table.insert(Palette,{255,155,0})
	table.insert(Palette,{255,231,39})
	table.insert(Palette,{0,226,50})
	table.insert(Palette,{41,173,255})
	table.insert(Palette,{132,112,169})
	table.insert(Palette,{255,119,168})
	table.insert(Palette,{255,214,197})

	Enums = LIP.load("ini/enums.ini")

	--Game object
	local g={}
	g.tile={}
	g.tile.width=tw
	g.tile.height=th
	g.width=gw
	g.height=gh
	return g
end

local function changestate(s)
	State=s
	Timer=0
	Pause=0
	Camera={}
	Camera.x=0
	Camera.y=0
	Camera.angle=0
	Camera.rotationvel=0
	Camera.shake=0
	
	Actors={}
	if State == 0 then
	
	elseif State == 3 then
		Player=actor.make(Enums.actors.car,0,0,0,0)
	end
end

return
{
	make = make,
	changestate = changestate,
}