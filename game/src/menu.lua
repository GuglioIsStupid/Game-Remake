require("src.player")
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
    if menu.active then
        love.graphics.rectangle("line", menu.x,menu.y,menu.w,menu.h)
        love.graphics.print(menu.startingtext, menu.x,menu.y-30)
    end
end