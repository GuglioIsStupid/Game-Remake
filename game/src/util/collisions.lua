require("src.util.AABB")
require("src.player")
require("src.menu")
require("src.util.generation")

collisions = {}

function collisions:update(dt)
    -- if bullets collide with enemy
    for i,bullet in ipairs(player.bullets) do
		for o,enemy in ipairs(enemies) do
			if AABB(enemy.x,enemy.y,enemy.w,enemy.h, bullet.x,bullet.y,bullet.w,bullet.h) then
				table.remove(player.bullets, i)
				table.remove(enemies, o)
			end
		end
	end
    -- if enemy collides with player
    for i,enemy in ipairs(enemies) do
		if AABB(enemy.x, enemy.y, enemy.w, enemy.h, player.x,player.y,player.w,player.h) then
			game.state = "eeee"
			table.remove(enemies, i)
			player.dead = true
			player.deathtext = true
			player.restart.active = true
		end
	end
	-- if bullet collides with menu box
	for e,b in ipairs(player.bullets) do
        if AABB(menu.x,menu.y,menu.w,menu.h, b.x,b.y,b.w,b.h) then
            game.state = 1
            table.remove(player.bullets, e)
            player.x = love.graphics.getWidth() / 2
            menu.active = false
			menu.x = 9999
			player.cooldown = 0
        end
	end
end