player = {}

-- sets the seed of randomness to random
math.randomseed(os.time())
love.graphics.setDefaultFilter("nearest", "nearest")

function player:load()
    self.dead = false
    self.x = love.graphics.getWidth() / 2
    self.y = 550
    self.w = 40
    self.h = 40
    self.speed = 390
    self.bullets = {}
    self.restart = false
    self.restart = {}
    self.restart.active = false
    self.cooldown = 0
    self.deathtext = false

    -- function for shooting
    player.shoot = function()
        if self.cooldown <= 0 and self.dead == false then
            self.cooldown = 180
            bullet = {}
            bullet.speed = 500
            self.bullet = {}
            self.bullet.x = self.x + 15
            self.bullet.y = self.y
            self.bullet.w = 10
            self.bullet.h = 10
            table.insert(self.bullets, self.bullet)
        end
    end
end

function player:draw()
    function continue()
        if self.deathtext == true then
            love.graphics.print("you died, continue?", self.x, self.y + -40)
        end
        
    end
    love.graphics.rectangle("fill", self.x,self.y, self.w,self.h)

    -- draws bullets
    for i,bullet in ipairs(self.bullets) do
        love.graphics.circle("fill", bullet.x, bullet.y, bullet.w, bullet.h)
    end
end

function player:input(dt)
    self.cooldown = self.cooldown - 1

    -- moves self right
    if love.keyboard.isDown("d") and self.dead == false or love.keyboard.isDown("right") and self.dead == false then 
        self.x = self.x + self.speed * dt
    end
    -- moves self left
    if love.keyboard.isDown("a") and self.dead == false or love.keyboard.isDown("left") and self.dead == false then
        self.x = self.x - self.speed * dt
    end
    -- if self goes outside of the left screen
    if self.x <= 0 then
        self.x = 0
    end
    -- if self goes outside of the right screen
    if self.x + self.w >= 800 then
        self.x = 800 - self.w
    end
    if love.keyboard.isDown("space") then
        self.shoot()
    end
    -- updates bullets
    for i,v in pairs(self.bullets) do
        v.y = v.y - bullet.speed * dt
        -- if bullets leave screen
        if v.y <= -600 then
            table.remove(self.bullets, i)
        end
    end
end

function player:update(dt)
    player:input(dt)
end