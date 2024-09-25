local image = file.read("esp.png")
local image_texture = utility.load_image(image_content)
local color = ui.new_color_picker("Scripts", "Elements", "Custom Image Color", 255, 255, 255, 255) 


function dxailwrukv()
    local players = entity.get_players()
    for _, players in pairs(players) do
        local clr = ui.get(color)
        local x, y, w, h = player:get_bbox()
        render.image(image_texture, x, y, w, h, clr[1], clr[2], clr[3], clr[4])
    end
end

cheat.set_callback("paint", dxailwrukv)