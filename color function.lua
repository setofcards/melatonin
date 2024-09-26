local colorpicker = ui.new_colorpicker("Scripts", "Elements", "Color Picker", 255, 255, 255, 255, false)

function rgb_to_dec(r, g, b)
    local dec = tonumber("0x" .. string.format("%02x", r) .. string.format("%02x", g) .. string.format("%02x", b))
    return dec
end

function on_paint()
    local clr = ui.get(colorpicker)
    local decimal_clr = rgb_to_dec(clr[1], clr[2], clr[3])
    print(decimal_clr)
end

cheat.set_callback("paint", on_paint)