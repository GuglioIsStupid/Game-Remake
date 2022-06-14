enemies = {}

local timer = 0

function enemies:load()
	
end

function enemies:draw()
	for _,v in ipairs(enemies) do
		love.graphics.rectangle("line", v.x, v.y, v.w, v.h)
	end
end

function enemies:update(dt)
	timer = timer - 1
	if timer <= 0 and game.state == 1 then
		timer = 5
		enemy = {}
		enemy.x = love.math.random(0, love.graphics.getWidth())
		enemy.y = -100 
		enemy.w = 40
		enemy.h = 40
		table.insert(enemies, enemy)
	end
	for _,v in ipairs(enemies) do
		v.y = v.y + 450 * dt
	end
end