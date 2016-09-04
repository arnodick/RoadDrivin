local function make(a)
	
end

local function control(a)
	
end

local function draw(a)
	love.graphics.draw(Spritesheet,Quads[1],a.x,a.y,a.d,1,1,8,8)
	--[[
	love.graphics.setColor(255, 0, 0, 255)
	love.graphics.line(a.x,a.y,a.x,a.y-20,a.x-10,a.y-40,a.x-30,a.y-60)
	love.graphics.setColor(255, 255, 255, 255)
	--love.graphics.arc("fill",a.x,a.y,a.r,10,30,16)
	--love.graphics.circle("fill",a.x,a.y,a.r,16)
	--]]
end

return
{
	make = make,
	control = control,
	draw = draw,
}