local function make(a)
	
end

local function control(a)
	
end

local function draw(a)
	love.graphics.draw(Spritesheet,Quads[1],a.x,a.y,a.d,1,1,8,8)
end

return
{
	make = make,
	control = control,
	draw = draw,
}