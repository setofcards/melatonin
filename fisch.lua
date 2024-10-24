local ingredient_esp = ui.new_checkbox("Scripts", "Elements", "Ingredient ESP")
local loc_dropdown = ui.new_dropdown("Scripts", "Elements", "Locations", {"Moosewood", "Roselit Bay", "Terrapin Island", "Snowcap Island", "Statue Of Sovereignty", "Mushgrove Swamp", "Sunstone Island", "Vertigo", "Keepers Altar"})
local witch_ingredients = {
    ["Spiders Eye"] = "Sphere",
    ["Candy Corn"] = "CandyCornBottom",
    ["Dark Art Skull"] = "Skull",
    ["Gaint Mushroom"] = "MeshPart",
    ["Strange Root"] =  "Leafs"
}

local location_coords = {
    ["Moosewood"] = vector(376, 134, 235),
    ["Roslit Bay"] = vector(-1465.7, 132.5, 708.1),
    ["Terrapin Island"] = vector(-96, 128, 1872),
    ["Snowcap Island"] = vector(2623, 135, 2368),
    ["Statue of Sovereignty"] = vector(37, 133, 1011),
    ["Mushgrove Swamp"] = vector(2423, 135, -718),
    ["Sunstone Island"] = vector(-919, 133, -1114),
    ["Vertigo"] = vector(-111, -515, 1145),
    ["Keepers Altar"] = vector(1307.1, -805.3, -128.7),
}

local data = game.get_data_model()
local workspace = data:find_first_child_of_class("Workspace")
local world = workspace:find_first_child("world")
local npc_folder = world:find_first_child("npcs")
local active_folder = workspace:find_first_child("active")

g_ingredients = {}

local function teleport()
    local player = entity.get_local_player()
    local player_hrp = player:bone_instance("HumanoidRootPart")
    
    local selected = ui.get(loc_dropdown)
    
    player_hrp:set_position(location_coords[selected]:unpack())
end

local tp_button = ui.new_button("Scripts", "Elements", "Teleport", teleport)

local function on_update()
    if (ui.get(ingredient_esp)) then
        g_ingredients = {}

        for _, ingreds in pairs(active_folder:get_children()) do
            local label = ingreds:get_name()
            
            if witch_ingredients[label] then
                local part_name = witch_ingredients[label]
                if witch_ingredients[label] and ingreds:find_first_child(part_name) ~= nil then
                    g_ingredients[#g_ingredients + 1] = {
                        pos = vector(ingreds:find_first_child(part_name):get_position()),
                    } 
                end
            end
        end
    end
end

local function on_paint()
    local local_player = entity.get_local_player()
    local local_position = vector(local_player:get_position())
    local x, y = cheat.get_window_size()
    if (ui.get(ingredient_esp)) then
        for _, ingred in pairs(g_ingredients) do
            local screen_pos = vector(utility.world_to_screen(ingred.pos:unpack()))
            if (screen_pos:is_zero()) then goto continue end
            local w, h = render.measure_text(0, false, "Ingredient")
            
            render.text(screen_pos.x - w / 2, screen_pos.y, 255, 255, 255, 255, 0, false, "Ingredient")

            ::continue::
        end
    end
end

-- unused
local function appraiser_tp()
    local npc = npc_folder:find_first_child("Appraiser")
    local npc_hrp = npc:find_first_child("HumanoidRootPart")
    local player = entity.get_local_player()
    local player_hrp = player:bone_instance("HumanoidRootPart")
    local npc_pos = vector(npc_hrp:get_position())

    player_hrp:set_position(npc_pos:unpack())
end

-- unused
local function moosewood_tp()
    local player = entity.get_local_player()
    local player_hrp = player:bone_instance("HumanoidRootPart")
    player_hrp:set_position(location_coords["Moosewood"]:unpack())
end

-- unused, realized the gps tool ingame gave the exact same coords
local function print_local_player()
    local local_player = entity.get_local_player()
    local local_position = vector(local_player:get_position())
    print(local_position.x)
    print(local_position.y)
    print(local_position.z)
end

cheat.set_callback("update", on_update)
cheat.set_callback("paint", on_paint)