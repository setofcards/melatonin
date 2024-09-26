local grenades_esp = ui.new_checkbox("Scripts", "Elements", "Grenades ESP")
local danger_close_indicator = ui.new_checkbox("Scripts", "Elements", "Danger Close Indicator")
local image = utility.load_image(file.read("warning.png"))

local game = game.get_data_model()
local workspace = game:find_first_child_of_class("Workspace")
local ignore = workspace:find_first_child("Ignore")

local g_grenades = {}

function on_update()
    if ui.get(grenades_esp) then
        g_grenades = {}
        local grenade_name
        local throwable_folder = workspace:find_first_child("Throwables")
            for _, grenade in pairs(throwable_folder:get_children()) do
                local grenade_pos
                local throwable_name = grenade:get_name() 
                if throwable_name == "Beach Ball" then return end
                if throwable_name == "Frag" then
                    local grenade_body = grenade:find_first_child("Body"):find_first_child("Meshes/M67Frag_Cube")
                    grenade_pos = vector(grenade_body:get_position())
                end
                if throwable_name == "Semtex" then
                    local grenade_body = grenade:find_first_child("Body"):find_first_child("Meshes/Semtex_Body2 (1)")
                    grenade_pos = vector(grenade_body:get_position())
                end
                
                g_grenades[#g_grenades + 1] = {
                    name = throwable_name,
                    pos  = grenade_pos
                }
            end
        ::continue::
    end
end

function on_paint()
    local local_player = entity.get_local_player()
    local local_position = vector(local_player:get_position())
    local x, y = cheat.get_window_size()
    local w, h = render.measure_text(0, false,"Semtex")
    local w1, h1 = render.measure_text(0, false, "Frag")
    local w2, h2 = render.measure_text(0, false, "GRENADE IS DANGER CLOSE TO YOU")

    if ui.get(grenades_esp) then
        for _, grenade in pairs(g_grenades) do
            local screen_pos = vector(utility.world_to_screen(grenade.pos:unpack()))
            if screen_pos:is_zero() then return end

            if (ui.get(danger_close_indicator)) then
                local distance = local_position:dist_to(grenade.pos)
                if distance < 20 then
                    render.text(x / 2 - w2 / 2, y / 2 + 150, 255, 0, 0, 255, 0, true, "GRENADE IS DANGER CLOSE TO YOU")
                    render.image(image, x / 2 - 17, y / 2 + 110, 35, 35, 255, 0, 0, 255)
                end
            end

            render.circle(screen_pos.x, screen_pos.y, 5, 255, 0, 0, 255, 120)
            if grenade.name == "Semtex" then
                render.text(screen_pos.x - w / 2, screen_pos.y + 5, 255, 0, 0, 255, 0, false, grenade.name)
            else if grenade.name == "Frag" then
                render.text(screen_pos.x -  w1 / 2, screen_pos.y + 5, 255, 0, 0, 255, 0, false, grenade.name)
            end

        end
    end
end
end

cheat.set_callback("update", on_update)
cheat.set_callback("paint", on_paint)

print("loaded. if u reading this u a bitch")