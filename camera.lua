local function make(x,y,a,s)
	local c={}
	c.x=x
	c.y=x
	c.angle=a
	c.scale=s
	c.rotationvel=0
	c.shake=0
	return c
end

local function control(c,t)
	if c.shake>0 then
		c.shake = c.shake - 1
	end
	--c.scale = math.clamp(6/Player.vel,0.1,3,true)
	c.scale = math.clamp(math.abs(6/Player.vel),0.1,2,true)
	c.x = t.x - Game.width/(2*c.scale)
	c.y = t.y - Game.height/(2*c.scale)-(t.vel/12)*Game.height/(2*c.scale)
	--c.x=t.x+8*t.vel+love.math.random(c.shake)*2-56

end

return
{
	make = make,
	control = control,
}