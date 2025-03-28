local handle = io.popen("tty")
local tty = handle:read("*a")
handle:close()

if tty:find("not a tty") then
    return
end

local reset = function()
    os.execute('printf "\\033]111\\007" > ' .. tty)
end

local update = function()
    local normal = vim.api.nvim_get_hl_by_name("Normal", true)
    local bg = normal["background"]
    local fg = normal["foreground"]
    if bg == nil then
        return reset()
    end

    local bghex = string.format("#%06x", bg)
    local fghex = string.format("#%06x", fg)

    os.execute('printf "\\033]11;' .. bghex .. '\\007" > ' .. tty)
    os.execute('printf "\\033]12;' .. fghex .. '\\007" > ' .. tty)
end

local setup = function()
    vim.api.nvim_create_autocmd({ "ColorScheme", "FileType", "UIEnter" }, { callback = update })
    vim.api.nvim_create_autocmd({ "VimLeavePre", "VimSuspend" }, { callback = reset })
end

setup()
