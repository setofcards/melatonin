local contains = function(b,c)for d=1,#b do if b[d]==c then return true end end;return false end

local fart = ui.new_multiselect("Scripts", "Elements", "shit ass multiselect", {"u", "fucking", "suck"})

local function piss()
    local multi = ui.get(fart);
    local x, y = cheat.get_window_size()


    -- learn 2 read u bots
    -- first two show that fucking or u is selected if its selected. Dumbass
    if contains(multi, "fucking") then
        local x1, y1 = render.measure_text(0, false,"fucking is not selected")
        render.text(x / 2 - x1 / 2, y / 2, 255, 255, 255, 255, 0, false, "fucking is selected")
    elseif contains(multi, "u") then
        local x1, y1 = render.measure_text(0, false, "u is not selected")
        render.text(x / 2 - x1 / 2, y / 2, 255, 255, 255, 255, 0, false, "u is selected")
    elseif not contains(multi, "okdfjshgisudfhgiu") then
        -- that shit dont exist
        local x1, y1 = render.measure_text(0, false,"okdfjshgisudfhgiu is not selected")
        render.text(x / 2 - x1 / 2, y / 2, 255, 255, 255, 255, 0, false, "okdfjshgisudfhgiu is not selected")
    end
end

cheat.set_callback("paint", piss)