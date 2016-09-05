local function make(a)
	
end

local function control(a)
	if love.keyboard.isDown("up") then
		a.vel = maths.clamp(a.vel + a.accel,-a.maxvel,a.maxvel,true)
	else
		if a.vel > 0 then
			a.vel = a.vel - a.decel
		else
			a.vel = a.vel + a.decel
		end
	end
	if love.keyboard.isDown("right") then
		a.d = a.d + 0.05
	elseif love.keyboard.isDown("left") then
		a.d = a.d - 0.05
	end
	Camera.x = a.x - Game.width/2
	Camera.y = a.y - Game.height/2
end

local function draw(a)
	love.graphics.draw(Spritesheet,Quads[0],a.x,a.y,a.d+math.pi/2,1,1,8,12)
end

return
{
	make = make,
	control = control,
	draw = draw,
}