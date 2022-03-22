--[[player = {}
require("src/AABB")

function player:load()
    player.dead = false
    player.x = love.graphics.getWidth() / 2
    player.y = 550
    player.w = 40
    player.h = 40
    player.speed = 390
    player.bullets = {}
    player.restart = false
    player.restart = {}
    player.restart.active = false
    player.cooldown = 0
    player.deathtext = false

    -- function for shooting
    player.shoot = function()
        if player.cooldown <= 0 and player.dead == false then
            player.cooldown = 180
            bullet = {}
            bullet.speed = 500
            player.bullet = {}
            player.bullet.x = player.x + 15
            player.bullet.y = player.y
            player.bullet.w = 10
            player.bullet.h = 10
            table.insert(player.bullets, player.bullet)
        end
    end
end

function player:draw()
    function continue()
        if player.deathtext == true then
            love.graphics.print("you died, continue?")
        end
        
    end
    love.graphics.rectangle("fill", player.x,player.y, player.w,player.h)
    -- draws bullets
    for i,v in pairs(player.bullets) do
        love.graphics.circle("fill", v.x,v.y, v.w,v.h)
    end
end

function player:update(dt)
    player.cooldown = player.cooldown - dt

    if love.keyboard.isDown("d") and player.dead == false then 
        player.x = player.x + player.speed * dt
    end
    if love.keyboard.isDown("a") and player.dead == false then
        player.x = player.x + -player.speed * dt
    end
    -- if player goes outside of the left screen
    if player.x <= 0 then
        player.x = 0
    end
    -- if player goes outside of the right screen
    if player.x + player.w >= 800 then
        player.x = 800 - player.w
    end
    if love.keyboard.isDown("space") then
        player.shoot()
    end
    -- updates bullets
    for i,v in pairs(player.bullets) do
        v.y = v.y + -bullet.speed * dt
    end
    --if bullets leave the screen
    for i,v in pairs(player.bullets) do
        if v.y <= -600 then
            table.remove(player.bullets, i)
        end
    end
end
]]--

player = {}
math.randomseed(os.time())
require("src/AABB")

function player:load()
    player.dead = false
    player.x = love.graphics.getWidth() / 2
    player.y = 550
    player.w = 40
    player.h = 40
    player.speed = 390
    player.bullets = {}
    player.restart = false
    player.restart = {}
    player.restart.active = false
    player.cooldown = 0
    player.deathtext = false

    -- function for shooting
    player.shoot = function()
        if player.cooldown <= 0 and player.dead == false then
            player.cooldown = 180
            bullet = {}
            bullet.speed = 500
            player.bullet = {}
            player.bullet.x = player.x + 15
            player.bullet.y = player.y
            player.bullet.w = 10
            player.bullet.h = 10
            table.insert(player.bullets, player.bullet)
        end
    end
end

function player:draw()
    love.graphics.setDefaultFilter("nearest", "nearest")
    function continue()
        if player.deathtext == true then
            love.graphics.print("you died, continue?", player.x, player.y+-40)
            --love.graphics.print()
        end
        
    end
    love.graphics.rectangle("fill", player.x,player.y, player.w,player.h)
    -- draws bullets
    for i,v in pairs(player.bullets) do
        love.graphics.circle("fill", v.x,v.y, v.w,v.h)
    end
end

function player:update(dt)
    player.cooldown = player.cooldown - 1

    if love.keyboard.isDown("d") and player.dead == false then 
        player.x = player.x + player.speed * dt
    end
    if love.keyboard.isDown("a") and player.dead == false then
        player.x = player.x + -player.speed * dt
    end
    -- if player goes outside of the left screen
    if player.x <= 0 then
        player.x = 0
    end
    -- if player goes outside of the right screen
    if player.x + player.w >= 800 then
        player.x = 800 - player.w
    end
    if love.keyboard.isDown("space") then
        player.shoot()
    end
    -- updates bullets
    for i,v in pairs(player.bullets) do
        v.y = v.y + -bullet.speed * dt
    end
    --if bullets leave the screen
    for i,v in pairs(player.bullets) do
        if v.y <= -600 then
            table.remove(player.bullets, i)
        end
    end
end