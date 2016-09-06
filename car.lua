local function make(a)
	a.td=0
	a.md=a.d
	a.f=0.06
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
		a.td=1
	elseif love.keyboard.isDown("left") then
		a.td=-1
	else
		a.td=0
	end
	if love.keyboard.isDown('x') then
		a.f=0.01
	else
		a.f=0.06
	end
	if a.td<0 then
		a.md = a.md - 0.08
	elseif a.td>0 then
		a.md = a.md + 0.08
	end
	if a.vel<4 then
		a.d=a.md
	else
		if a.d < a.md then
			a.d = a.d + a.f
		else
			a.d = a.d - a.f
		end
	end
end

local function draw(a)
	love.graphics.draw(Spritesheet,Quads[0],a.x,a.y,a.md+math.pi/2,1,1,8,10)
end

return
{
	make = make,
	control = control,
	draw = draw,
}