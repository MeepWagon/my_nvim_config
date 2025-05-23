-- This is the code required for ~/.config/nvim/init.lua
-- to load all the nvim_config.lua files in a project


local config_path = vim.fn.getcwd() 
local local_config_path = "/config/nvim_config"

local final_path = nil
function ascend_filepath(path)
    if vim.fn.filereadable(path.."/config/nvim_config.lua") == 0 then
        local start_index = path:find("/([^/]+)$")
        local modified_path = string.sub(path, 1, start_index-1)
        -- print(modified_path)
        ascend_filepath(modified_path)
    elseif vim.fn.filereadable(path.."/config/nvim_config.lua") == 1 then
        final_path = path
        return
    end
end

ascend_filepath(config_path)

if final_path ~= nil then
    dofile(final_path.."/config/nvim_config.lua")
else
    print("No nvim_config.lua found.")
end
