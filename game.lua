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
		--actor.make(Enums.actors.tree,0,120,0,0)
	end
end

return
{
	make = make,
	changestate = changestate,
}