stars = {}

function stars:load()
    timer = 0
end

function stars:draw()
    for i,star in ipairs(stars) do
        love.graphics.draw(star.img, star.x, star.y, star.wh, star.wh)
    end
end

function stars:update(dt)
    timer = timer - 1
    if timer < 0 then
        types = love.math.random(1, 3)
        timer = love.math.random(200, 350)
        star = {}
        star.x = love.math.random(0, love.graphics.getWidth())
        star.y = love.graphics.getHeight() + 100
        -- width and height of stars
        star.wh = love.math.random(5, 9)
        
        if types == 1 then
            star.img = love.graphics.newImage("src/img/star1.png")
        end
        if types == 2 then
            star.img = love.graphics.newImage("src/img/star2.png")
        end
        if types == 3 then
            star.img = love.graphics.newImage("src/img/star3.png")
        end
        table.insert(stars, star)
    end
    for i,v in ipairs(stars) do
        v.y = v.y - 40 * dt
        --print(#stars)
        if v.y < -40 then
            table.remove(stars, i)
        end
    end
end