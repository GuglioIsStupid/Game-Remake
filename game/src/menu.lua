require("src/player")
menu = {}

function menu:load()
    menu.x = player.x + 10
    menu.y = 300
    menu.w = 10
    menu.h = 10
    menu.active = true
    menu.startingtext = "shoot to play!"
end

function menu:draw()
    if menu.active == true then
        love.graphics.rectangle("line", menu.x,menu.y,menu.w,menu.h)
        love.graphics.print(menu.startingtext, menu.x,menu.y-30)
        for e,b in ipairs(player.bullets) do
        if AABB(menu.x,menu.y,menu.w,menu.h, b.x,b.y,b.w,b.h) then
            game.state = 1
            table.remove(player.bullets, e)
            player.x = love.graphics.getWidth() / 2
            menu.active = false
        end
    end
end
    
    
end