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
	_G[Enums.names[a.t]]["control"](a)
	a.vec[1]=math.cos(a.d)
	a.vec[2]=math.sin(a.d)
	a.x = a.x + a.vec[1] * a.vel
	a.y = a.y + a.vec[2] * a.vel
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