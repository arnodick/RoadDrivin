local function make(t,x,y,d,vel)
	local actor={}
	actor.t=t
	actor.x=x
	actor.y=y
	actor.d=d
	actor.vec={math.cos(d),math.sin(d)}
	actor.vel=vel
	actor.grav=false
	actor.delta=Timer

	_G[Enums.names[actor.t]]["make"](actor)
	table.insert(Actors,actor)
	return actor
end

local function control(a)
	if a.t==Enums.actors.car then
	a.vec[1]=math.cos(a.d)
	a.vec[2]=math.sin(a.d)
	local coll = road.collision(a)
	if coll then
		a.x = Road.map:evaluate(math.abs(a.y/Road.length)) + 1
	else
		a.x = a.x + a.vec[1] * a.vel
	end
	a.y = a.y + a.vec[2] * a.vel
	end
	_G[Enums.names[a.t]]["control"](a)
end

local function draw(a)
	_G[Enums.names[a.t]]["draw"](a)
end

local function makehitbox(a,x,y,w,h)
	a.hitbox={}
	a.hitbox.x=x
	a.hitbox.y=y
	a.hitbox.w=w
	a.hitbox.h=h
end

local function getname(a)
	--for i,v in ipairs(Enums.actors)
end

return
{
	make = make,
	control = control,
	draw = draw,
	makehitbox = makehitbox,
}