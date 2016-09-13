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
	local rx=Road.map:evaluate(math.abs((a.y+a.vec[2]*a.vel)/Road.length)) 
	if a.x+a.vec[1]*a.vel < rx or a.x < rx then
		return 1
	elseif a.x+a.vec[1]*a.vel > rx +100 or a.x > rx +100 then
		return -1
	else
		return 0
	end
end

local function direction(r,y)
	return vector.direction(r.map:getDerivative():evaluate(math.abs(y/r.length)))
end

local function control(r)
	
end

local function draw(r)
	love.graphics.line(r.map:render(1))
	love.graphics.translate(100,0)
	love.graphics.line(r.map:render(1))
	love.graphics.translate(-100,0)
	if DebugMode then
		love.graphics.setColor(Palette[9])
		local rx = r.map:evaluate(math.abs(Player.y/r.length))
		--local der = r.map:getDerivative()
		local vecx,vecy = vector.normalize(r.map:getDerivative():evaluate(math.abs(Player.y/r.length)))
		--print(vector.direction(vecx,vecy))
		print(road.direction(r,Player.y))
		local len = 20
		--local vecx = math.cos(der)
		--local vecy = math.sin(der)
		love.graphics.line(rx,Player.y,rx+vecx*len,Player.y+vecy*len)
		love.graphics.line(rx,Player.y,rx-vecx*len,Player.y-vecy*len)
		--love.graphics.points(rx-10,Player.y)
		love.graphics.setColor(Palette[8])
	end
end

return
{
	make = make,
	collision = collision,
	draw = draw,
	direction = direction,
}