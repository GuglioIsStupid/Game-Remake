require("src.player")
require("src.menu")
require("src.util.generation")
require("src.util.collisions")
require("src.util.stars")

game = {}
game.state = 3

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")
	-- render stars first
	stars:load()
	player:load()
	enemies:load()
	menu:load()
end

function love.draw()
	stars:draw()
	menu:draw()
	love.graphics.print("press escape at any time to quit")
	player:draw()
	if player.restart.active == true then
		game.state = "main"
		continue()
	end
	
	enemies:draw()

	-- keeps track of how many enemies there are
	--love.graphics.print("Enemies: " .. #enemies)
end

function love.update(dt)
	stars:update(dt)
	function love.keypressed(key)
		if key == "return" and player.restart.active == true then
			player.restart.active = false
			game.state = 1
			player.x = love.graphics.getWidth() / 2
			player.dead = false
			player.deathtext = false
		end
		if key == "escape" then
			love.event.quit()
		end
	end
	player:update(dt)
	enemies:update(dt)

	-- Despawn off-screen enemies and other stuff.
	for i = #enemies, 1, -1 do
		local enemy = enemies[i]

		if enemy.y > love.graphics.getHeight() then
			table.remove(enemies, i)
		end			
	end
	collisions:update(dt)
end