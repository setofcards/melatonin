-- i gave up coming up with variable names so some of them are the result
-- of me just slapping my hand on the keyboard

local grenades_esp = ui.new_checkbox("Scripts", "Elements", "Grenades ESP")
local grenades_color = ui.new_colorpicker("Scripts", "Elements", "Friendly Nade Color", 0, 255, 0, 255, false)
local enemygrenades_esp = ui.new_checkbox("Scripts", "Elements", "Only Show Enemy Nades")
local enemynade_color = ui.new_colorpicker("Scripts", "Elements", "Enemy Nade Color", 255, 0, 0, 255, false)
local danger_close_indicator = ui.new_checkbox("Scripts", "Elements", "Danger Close Indicator")
local size = ui.new_slider_int("Scripts", "Elements", "Circle Size", 1, 10, 1)
local image = utility.load_image(file.read("warning.png"))


local game = game.get_data_model()
local workspace = game:find_first_child_of_class("Workspace")
local ignore = workspace:find_first_child("Ignore")

g_grenades = {}

function on_update()
    if (ui.get(grenades_esp)) then
        local misc = ignore:find_first_child("Misc")
        g_grenades = {}
        local fart = ""
        for _, grenades in pairs(misc:get_children()) do

            if grenades:get_name() ~= "Trigger" then
                goto continue
            end
             -- on larry this whole function is fucked
            for _, edfghsfgh in pairs(grenades:get_children()) do
                if edfghsfgh:get_name() == "Indicator" then
                    for _, piss in pairs(edfghsfgh:get_children()) do
                        fart = piss:get_name()
                    end
                end
            end

            g_grenades[#g_grenades + 1] = {
                name == "Grenade",
                pos = vector(grenades:get_position()),
                team = fart
            }
            ::continue::
        end 
    end
end

function on_draw()
    local local_player = entity.get_local_player()
    local local_position = vector(local_player:get_position())
    local x, y = cheat.get_window_size()
    local w, h = render.measure_text(0, true, "GRENADE IS DANGER CLOSE TO YOU")
    if (ui.get(grenades_esp)) then
        for _, grenade in pairs(g_grenades) do           
            local screen_pos = vector(utility.world_to_screen(grenade.pos:unpack()))
            if (screen_pos:is_zero()) then goto continue end

            local w, h = render.measure_text(0, false, "Grenade")
            local w1, h1 = render.measure_text(0, true, "GRENADE IS DANGER CLOSE TO YOU")
            local clr = ui.get(grenades_color)
            local clr_1 = ui.get(enemynade_color)
            local sedrfghiku = ui.get(size)

            local game_team = local_player:get_team();
            -- on larry hoover this shit ass and this could definitely be improved but im lazy

            if (ui.get(danger_close_indicator)) then
                local distance = local_position:dist_to(grenade.pos)
                if distance < 20 then
                    render.text(x / 2 - w1 / 2, y / 2 + 150, 255, 0, 0, 255, 0, true, "GRENADE IS DANGER CLOSE TO YOU")
                    render.image(image, x / 2 - 17, y / 2 + 110, 35, 35, 255, 0, 0, 255)
                end
            end

            -- why the fuck is the logic reversed
            -- wait its not
            -- wait it is
            -- i dont even know anymore bro fuck this team check
            if ui.get(enemygrenades_esp) then
                if game_team == "Phantoms" then
                    if grenade.team == "Friendly" then
                        render.circle(screen_pos.x, screen_pos.y, sedrfghiku, clr_1[1], clr_1[2], clr_1[3], clr_1[4], 120) 
                    end
                elseif game_team == "Ghosts" then
                    if grenade.team == "Friendly" then
                        render.circle(screen_pos.x, screen_pos.y, sedrfghiku, clr_1[1], clr_1[2], clr_1[3], clr_1[4], 120) 
                    end
                end
            else
                if game_team == "Phantoms" then
                    if grenade.team == "Enemy" then
                        render.circle(screen_pos.x, screen_pos.y, sedrfghiku, clr[1], clr[2], clr[3], clr[4], 120) 
                    end
                    if grenade.team == "Friendly" then
                        render.circle(screen_pos.x, screen_pos.y, sedrfghiku, clr_1[1], clr_1[2], clr_1[3], clr_1[4], 120) 
                    end
                elseif game_team == "Ghosts" then
                    if grenade.team == "Enemy" then
                        render.circle(screen_pos.x, screen_pos.y, sedrfghiku, clr[1], clr[2], clr[3], clr[4], 120) 
                    end
                    if grenade.team == "Friendly" then
                        render.circle(screen_pos.x, screen_pos.y, sedrfghiku, clr_1[1], clr_1[2], clr_1[3], clr_1[4], 120) 
                    end

                end
            end
            
       

            ::continue::
        end
    end
end

cheat.set_callback("update", on_update)
cheat.set_callback("paint", on_draw)

print("loaded the script bitch ass nigga")