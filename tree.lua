local function make(a)
	a.swayoff = love.math.random(50)
end

local function control(a)
	
end

local function draw(a)
	local shear = (math.sin(Timer/35+a.swayoff))/2 + 0.3
	love.graphics.draw(Spritesheet,Quads[1],a.x,a.y,a.d,2,2,16,16,shear)
end

return
{
	make = make,
	control = control,
	draw = draw,
}