libraries = require("libraries")
libraries.load()
SFX = sfx.load()

function love.load()
---[[
 	Shader = love.graphics.newShader
	[[
	extern number screenWidth;
	extern number screenHeight;
	extern number random1;
	vec4 effect(vec4 color,Image texture,vec2 texture_coords,vec2 screen_coords)
	{
		vec2 neigh = texture_coords;
		neigh.x = neigh.x + 1;
		vec4 pixel = Texel(texture, texture_coords);
		vec4 pixel_n = Texel(texture, neigh);
		number xx = floor(texture_coords.x * screenWidth );
		number yy = floor(texture_coords.y * screenHeight );
		number ym = mod(yy,3);


		if (mod(xx,2) == 0)
		{
			pixel.r = pixel.r + 0.5 + random1;
		}
		if (mod(yy,2) == 0)
		{
			pixel.b = pixel.b +0.5;
		}
		if (floor(mod(xx,4)) == 0)
		{
			pixel.y = random1;
		}
		
		return pixel;
    }
 	]]
--]]

	--Game = game.make(16,16,320,240)
	--Game = game.make(16,16,640,480)
	Game = game.make(16,16,160,120)

	Shader:send("screenWidth", Game.width)
	Shader:send("screenHeight", Game.height)
	
	Screen = screen.update(Game.width,Game.height)

	game.changestate(State)

	--graphics settings and asset inits
	love.graphics.setDefaultFilter("nearest","nearest",1) --clean SPRITE scaling
	love.graphics.setLineWidth(50)
	love.graphics.setLineStyle("rough") --clean SHAPE scaling
	love.graphics.setBlendMode("replace")
	love.mouse.setVisible(false)
	Spritesheet, Quads = sprites.load("gfx/sprites.png", Game.tile.width, Game.tile.height)

	Font = love.graphics.newFont("fonts/pico8.ttf",72)
	FontDebug = love.graphics.newFont("fonts/lucon.ttf",20)
	Font:setFilter("nearest","nearest",0) --clean TEXT scaling
	Font:setLineHeight(1.5)
	love.graphics.setFont(Font)

	Canvas = {}
	Canvas.game = love.graphics.newCanvas(Game.width,Game.height) --sets width and height of fictional retro video game (320x240)
	Canvas.debug = love.graphics.newCanvas(Screen.width,Screen.height) --sets width and height of debug overlay (size of window)
end

function love.keypressed(key,scancode,isrepeat)
	
	if State == Enums.states.intro then
		if key=="z" then
			State = State + 1
			game.changestate(State)
		end
	elseif State == Enums.states.title then
		if key=="z" then
			State = State + 1
			game.changestate(State)
		end
	elseif State == Enums.states.options then
		if key=="z" then
			State = State + 1
			game.changestate(State)
		end
	elseif State == Enums.states.game then
		if key=="z" then
	
		end
	end
	if key == 'escape' then
		love.event.quit()
	elseif key == '`' then
		DebugMode = not DebugMode
	elseif key == 'f' then
		love.window.setFullscreen(not love.window.getFullscreen())
		Screen = screen.update(Game.width,Game.height)
		Canvas.debug = love.graphics.newCanvas(Screen.width,Screen.height) --sets width and height of debug overlay (size of window)
	end
end

function love.update(dt)
	if State == Enums.states.intro then

	elseif State == Enums.states.title then

	elseif State == Enums.states.game then
		if Pause == 0 then
			for i,v in ipairs(Actors) do
				actor.control(v)
			end
			if love.keyboard.isDown("up") then
				Screen.scale = Screen.scale + 0.004
			elseif love.keyboard.isDown("down") then
				Screen.scale = Screen.scale - 0.004
			end
			Screen.scale = Screen.scale + math.sin(Timer/20)/20
			if love.keyboard.isDown("left") then
				Camera.rotationvel = Camera.rotationvel - 0.001
			elseif love.keyboard.isDown("right") then
				Camera.rotationvel = Camera.rotationvel + 0.001
			else
				if Camera.rotationvel < 0 then
					Camera.rotationvel = Camera.rotationvel + 0.002
				elseif Camera.rotationvel > 0 then
					Camera.rotationvel = Camera.rotationvel - 0.002
				end
				if (Camera.rotationvel > -0.002 and Camera.rotationvel<0) or (Camera.rotationvel < 0.002 and Camera.rotationvel>0) then
					--Camera.rotationvel = 0
					Camera.rotationvel = 0 + love.math.random(0.002)-1
				end
			end
			Camera.angle = Camera.angle + Camera.rotationvel
		else
			Pause = Pause - 1
		end
		if DebugMode then
			DebugList = debugger.update()
		end
	end
	Timer = Timer + 1
end

function love.draw(dt)
	
	love.graphics.setCanvas(Canvas.game) --sets drawing to the 320x240 canvas
									local width=Screen.width
			local height=Screen.height
		love.graphics.clear() --cleans that messy ol canvas all up, makes it all fresh and new and good you know
		love.graphics.setBlendMode("replace")
		love.graphics.translate(-Camera.x,-Camera.y)
		if State == Enums.states.intro then
			love.graphics.print("intro",160,120)
		elseif State == Enums.states.title then
			love.graphics.print("title",160,120)
		elseif State == Enums.states.options then
			love.graphics.print("options",160,120)
		elseif State == Enums.states.game then
			love.graphics.translate(Game.width/2,Game.height/2)
			love.graphics.rotate(Camera.angle)
			for i,v in ipairs(Actors) do
				actor.draw(v)
			end
			--love.graphics.printf("VIDEOGAME", -100,-50,200,"center")
			--love.graphics.printf( {Palette[math.floor(love.math.random(10))],"VIDEO",Palette[math.floor(love.math.random(10))],"GAMEZ"}, -100, -50, 200, "center") 
			love.graphics.printf( {Palette[4],"VIDEO",Palette[3],"GAMEZ"}, -100, -50, 200, "center") 

			--love.graphics.printf("GAME", Game.width/2,Game.height/2, 20, "left")
			--love.graphics.print("game",Game.width/2,Game.height/2)
	
			love.graphics.translate(-Game.width/2, -Game.height/2)
		end
		--love.graphics.rectangle("line",0,0,Game.width,Game.height)
		love.graphics.setColor(255, 255, 255, 255) --sets draw colour back to normal
	love.graphics.setCanvas() --sets drawing back to screen



		--[[
						local width=Screen.width
			local height=Screen.height
			love.graphics.translate(width/2, height/2)
			love.graphics.rotate(Camera.angle)
			love.graphics.translate(-width/2, -height/2)
		]]
	--love.graphics.translate(width/2, height/2)
	love.graphics.origin()
	if not DebugMode and State ~= -1 then
		love.graphics.setShader(Shader)
	end
	local width=Screen.width
			local height=Screen.height
	--love.graphics.draw(Canvas.game,width/2,height/2,Camera.angle,Screen.scale,Screen.scale,Game.width/2,Game.height/2) --just like draws everything to the screen or whatever
	love.graphics.draw(Canvas.game,width/2,height/2,0,Screen.scale,Screen.scale,Game.width/2,Game.height/2) --just like draws everything to the screen or whatever
	--love.graphics.draw(Canvas.game,width/2,height/2,0,1,1,Game.width/2,Game.height/2) --just like draws everything to the screen or whatever
	
	
	love.graphics.setShader()
	if DebugMode then
		love.graphics.setCanvas(Canvas.debug) --sets drawing to the 1280 x 960 debug canvas
		love.graphics.clear() --cleans that messy ol canvas all up, makes it all fresh and new and good you know
		--love.graphics.setBackgroundColor(0,0,0,0)
		debugger.draw(DebugList)
		love.graphics.setCanvas() --sets drawing back to screen
		love.graphics.setBlendMode("alpha")
		love.graphics.origin()
		--love.graphics.draw(Canvas.debug,0+Camera.x*Screen.scale+Screen.xoff,0+Camera.y*Screen.scale,0,1,1,0,0) --just like draws everything to the screen or whatever
		love.graphics.draw(Canvas.debug,0,0,0,1,1,0,0) --just like draws everything to the screen or whatever
	end
end