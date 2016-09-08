local function make(a)
	a.td=0
	a.md=a.d
	a.f=0.03
end

local function control(a)
	if love.keyboard.isDown('x') then
		a.f=0.01
		a.vel = a.vel - a.decel*1.5
	else
		if a.vel<4 then
			a.f=0.05
		else
			a.f=0.03
		end
		if love.keyboard.isDown("up") then
			a.vel = maths.clamp(a.vel + a.accel,-a.maxvel,a.maxvel,true)
		else
			if a.vel > a.decel then
				a.vel = a.vel - a.decel
			elseif a.vel < a.decel then
				a.vel = a.vel + a.decel
			else
				a.vel = 0
			end
		end	
	end

	if love.keyboard.isDown("right") then
		a.td=1
	elseif love.keyboard.isDown("left") then
		a.td=-1
	else
		a.td=0
	end
	if a.td<0 then
		a.md = maths.clamp(a.md - 0.06, a.d - math.pi/3, a.d + math.pi/3, true)
	elseif a.td>0 then
		a.md = maths.clamp(a.md + 0.06, a.d - math.pi/3, a.d + math.pi/3, true)
	end

	if a.d < a.md then
		a.d = a.d + a.f
	else
		a.d = a.d - a.f
	end
	if math.abs(a.d - a.md) > 1 then
		skid.make(a.x,a.y)
	end
end

local function draw(a)
	love.graphics.draw(Spritesheet,Quads[0],a.x,a.y,a.md+math.pi/2,1,1,8,10)
	if DebugMode then
		love.graphics.setColor(Palette[9])
		love.graphics.line(a.x,a.y,a.x+math.cos(a.md)*20,a.y+math.sin(a.md)*20)
		love.graphics.setColor(Palette[8])
		love.graphics.line(a.x,a.y,a.x+math.cos(a.d)*30,a.y+math.sin(a.d)*30)
	end
end

return
{
	make = make,
	control = control,
	draw = draw,
}