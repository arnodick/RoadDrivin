local function add(skid,x,y)
	table.insert(skid,x)
	table.insert(skid,y)
	print(x)
	print(y)
end

local function make(x,y)
	local s={}
	table.insert(Skids,s)
	add(Skids[#Skids],x,y)
end

local function control(s)

end

local function draw(s)
	love.graphics.setColor(Palette[7])
	love.graphics.rectangle("fill",s.x,s.y,2,2)
	love.graphics.setColor(Palette[8])
end

return
{
	add = add,
	make = make,
	control = control,
	draw = draw,
}