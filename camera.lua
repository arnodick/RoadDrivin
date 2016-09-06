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
	
	c.x=t.x+8*t.vel+love.math.random(c.shake)*2-56
	if t.y<-60 then
		c.y=-118+t.y+60
	else
		c.y=-118
	end
end

return
{
	make = make,
	control = control,
}