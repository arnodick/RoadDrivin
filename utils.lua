--BRITISH STYLE motherfuckers

local function clamp(v,mi,ma,h)
	if h then
		if v<mi then v=mi
		elseif v>ma then v=ma
		end
	else
		if v<mi then v=ma
		elseif v>ma then v=mi
		end
	end
	return v
end

local function choose(...)
	local arg={...}
	return arg[love.math.random(#arg)]
end

math.clamp = clamp
math.choose = choose