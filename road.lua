local function make(ylen,xcur,yint)
	local points = {}
	for a=0,ylen do
		table.insert(points,love.math.random(-xcur,xcur))
		table.insert(points,a*-yint)
		--actor.make(Enums.actors.tree,points[a*2-1],points[a*2],0,0)
	end
	local road = {}
	road.map = love.math.newBezierCurve(points)
	road.length = ylen*yint
	for a=1,200 do
		local x,y = road.map:evaluate(love.math.random(1000)/1000)
		actor.make(Enums.actors.tree,math.choose(x-love.math.random(50)-20,x+love.math.random(50)+20+100),y,0,0)
	end
	return road
end

local function collision(a)

	if a.x+a.vec[1] < Road.map:evaluate(math.abs(a.y/Road.length)) then
		return true
	else
		return false
	end
end

local function control(r)
	
end

local function draw(r)
	
end

return
{
	make = make,
	collision = collision,
}