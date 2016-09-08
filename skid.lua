local function add(x,y)
	table.insert(Skids[#Skids],x)
	table.insert(Skids[#Skids],y)
end

local function make(x,y)
	local s={}
	table.insert(Skids,s)
	add(x,y)
	print(x)
	print(y)
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