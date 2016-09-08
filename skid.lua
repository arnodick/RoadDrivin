local function make(x,y)
	table.insert(Skids,x)
	table.insert(Skids,y)
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
	make = make,
	control = control,
	draw = draw,
}