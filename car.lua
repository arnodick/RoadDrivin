local function make(a)
	--TODO: car type stuff here. use input for actor.make like in spacetank
	a.accel=0.04
	a.decel=0.02
	a.maxvel=6
	a.td=0
	a.md=a.d
	a.f=0.03
	a.turnspeed=0.06
	a.turnfactorinit=4
	a.turnfactor=a.turnfactorinit
	a.skidlast=0
	a.skidstart=0.5
	a.tirebl={}
	a.tirebr={}
	--a.tirebl.d=math.pi+math.pi/3
	a.tirebl.d=math.pi
	a.tirebl.l=4
	a.tirebl.x=a.x+math.cos(-a.md-math.pi/2+a.tirebl.d)*a.tirebl.l
	a.tirebl.y=a.y-math.sin(-a.md-math.pi/2+a.tirebl.d)*a.tirebl.l
	--a.tirebr.d=math.pi*2-math.pi/3
	a.tirebr.d=0
	a.tirebr.l=4
	a.tirebr.x=a.x+math.cos(-a.md-math.pi/2+a.tirebr.d)*a.tirebr.l
	a.tirebr.y=a.y-math.sin(-a.md-math.pi/2+a.tirebr.d)*a.tirebr.l
end

local function control(a)
	if love.keyboard.isDown('x') then
		a.turnfactor=2
		a.f=0.01
		--a.vel = a.vel - a.decel*1.5
		--a.vel = a.vel - a.decel*2
		a.vel = math.clamp(a.vel - a.decel*3,0,a.maxvel,true)
	else
		if a.turnfactor < a.turnfactorinit then
			a.turnfactor = a.turnfactor +0.1
		end
		if a.vel<4 then
			a.f=0.05
		else
			a.f=0.03
		end
		if love.keyboard.isDown("up") then
			a.vel = math.clamp(a.vel + a.accel,-a.maxvel,a.maxvel,true)
		elseif love.keyboard.isDown("down") then
			a.vel = math.clamp(a.vel - a.decel*2,-a.maxvel,a.maxvel,true)
		else
			if a.vel > a.decel then
				a.vel = a.vel - a.decel
			elseif a.vel < -a.decel then
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

	a.md = math.clamp(a.md + a.td*a.turnspeed, a.d - math.pi/a.turnfactor, a.d + math.pi/a.turnfactor, true)

	if a.d < a.md - a.f then
		a.d = a.d + a.f
	elseif a.d > a.md + a.f then
		a.d = a.d - a.f
	else
		a.d = a.md
	end
	
	a.tirebl.x=a.x+math.cos(-a.md-math.pi/2+a.tirebl.d)*a.tirebl.l
	a.tirebl.y=a.y-math.sin(-a.md-math.pi/2+a.tirebl.d)*a.tirebl.l

	a.tirebr.x=a.x+math.cos(-a.md-math.pi/2+a.tirebr.d)*a.tirebr.l
	a.tirebr.y=a.y-math.sin(-a.md-math.pi/2+a.tirebr.d)*a.tirebr.l
	
	if Timer%3==0 then
		local skidpower = math.abs(a.d - a.md)
		if skidpower > a.skidstart then--TODO: optomize this with local var
			if a.skidlast<=a.skidstart then
				skid.make(a.tirebl.x,a.tirebl.y)
				skid.make(a.tirebr.x,a.tirebr.y)
			else
				skid.add(Skids[#Skids-1],a.tirebl.x,a.tirebl.y)--TODO:implement this, fix .make
				skid.add(Skids[#Skids],  a.tirebr.x,a.tirebr.y)--TODO:implement this, fix .make
			end
		end
		a.skidlast=skidpower
	end
end

local function draw(a)
	love.graphics.draw(Spritesheet,Quads[0],a.x,a.y,a.md+math.pi/2,1,1,8,10)
	if DebugMode then
		love.graphics.setColor(Palette[9])
		love.graphics.line(a.x,a.y,a.x+math.cos(a.md)*20,a.y+math.sin(a.md)*20)
		love.graphics.setColor(Palette[8])
		love.graphics.line(a.x,a.y,a.x+math.cos(a.d)*30,a.y+math.sin(a.d)*30)
		
		love.graphics.setColor(Palette[10])
		--[[
		local tlx = a.x+math.cos(-a.md-math.pi/2+a.tirebl.d)*a.tirebl.l
		local tly = a.y-math.sin(-a.md-math.pi/2+a.tirebl.d)*a.tirebl.l
		local trx = a.x+math.cos(-a.md-math.pi/2+a.tirebr.d)*a.tirebr.l
		local try = a.y-math.sin(-a.md-math.pi/2+a.tirebr.d)*a.tirebr.l
		]]
		
		--love.graphics.points(a.tirebl.x,a.tirebl.y)
		--love.graphics.points(a.tirebr.x,a.tirebr.y)
		love.graphics.line(a.x,a.y,a.tirebl.x,a.tirebl.y)
		love.graphics.line(a.x,a.y,a.tirebr.x,a.tirebr.y)
		--love.graphics.rectangle("fill",a.tirebl.x,a.tirebl.y,2,2)
		--love.graphics.rectangle("fill",a.tirebr.x,a.tirebr.y,2,2)
	end
end

return
{
	make = make,
	control = control,
	draw = draw,
}