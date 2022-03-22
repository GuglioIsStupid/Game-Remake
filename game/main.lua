require("src/player")
require("src/menu")
game = {}
game.state = 3

local enemies = {}
math.randomseed(os.time())

local function spawnNewEnemy()
		local enemy = {
		x = math.random(0, 800),
		y = -100,
		w = 40,
		h = 40,
	}

	function enemy:update(dt)
		self.y = self.y + 450 * dt
	end

	function enemy:draw()
		love.graphics.rectangle("line", self.x,self.y, self.w,self.h)
	end

	table.insert(enemies, enemy)
end

local enemySpawnTimer = 0

local function updateEnemySpawner(dt)
	if game.state == 1 then
		enemySpawnTimer = enemySpawnTimer - dt
	end
	

	if enemySpawnTimer < 0 and game.state == 1 then
		enemySpawnTimer = 0.1
		spawnNewEnemy()
	end
end

function love.load()
	player:load()
	menu:load()
end

function love.update(dt)
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
	
	-- Update enemies and other stuff.
	updateEnemySpawner(dt)

	for _, enemy in ipairs(enemies) do
		enemy:update(dt)
	end

	-- Despawn off-screen enemies and other stuff.
	for i = #enemies, 1, -1 do
		local enemy = enemies[i]

		if enemy.y > love.graphics.getHeight() then
			table.remove(enemies, i)
		end			
	end
	for i,bullet in ipairs(player.bullets) do
		for o,enemy in ipairs(enemies) do
			if AABB(enemy.x,enemy.y,enemy.w,enemy.h, bullet.x,bullet.y,bullet.w,bullet.h) then
				table.remove(player.bullets, i)
				table.remove(enemies, o)
			end
		end
	end
	for _,enemy in ipairs(enemies) do
		if AABB(enemy.x, enemy.y, enemy.w, enemy.h, player.x,player.y,player.w,player.h) then
			game.state = "eeee"
			player.dead = true
			player.deathtext = true
			player.restart.active = true
		end
	end
end

function love.draw()
	menu:draw()
	love.graphics.print("press escape at any time to quit")
	player:draw()
	if player.restart.active == true then
		game.state = "main"
		continue()
	end
	for _, enemy in ipairs(enemies) do
		enemy:draw()
	end

	--love.graphics.print("Enemies: " .. #enemies)
end