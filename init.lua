-- This is the code required for ~/.config/nvim/init.lua


-- require("plugins")

-- Load all the nvim_config.lua files in a project
local config_path = vim.fn.getcwd() 
local local_config_path = "/config/nvim_config"

local project_root_dir = nil
function ascend_filepath(path, local_path)
    if vim.fn.filereadable(path.."/config/nvim_config.lua") == 0 then
        local start_index = path:find("/([^/]+)$")
        if start_index ~= nil then
            local modified_path = string.sub(path, 1, start_index-1)
            ascend_filepath(modified_path)
        end
    elseif vim.fn.filereadable(path.."/config/nvim_config.lua") == 1 then
        project_root_dir = path
        return
    end
end

-- Get project config file
ascend_filepath(config_path)
if project_root_dir ~= nil then
    -- package.path = package.path..";"..project_root_dir.."/config/plugins/?.lua"
    -- package.path = package.path..";"..project_root_dir.."/config/?.lua"
    -- package.path = package.path..";"..project_root_dir.."/plugins/nvim-tree/?.lua"
    if project_root_dir then
        print(project_root_dir)
        -- Add these paths in correct order
        package.path = package.path .. ";" .. project_root_dir .. "/config/lua/?.lua"
        package.path = package.path .. ";" .. project_root_dir .. "/config/lua/?/init.lua"
        package.path = package.path .. ";" .. project_root_dir .. "/config/plugins/?/init.lua"
        package.path = package.path .. ";" .. project_root_dir .. "/config/plugins/nvim-tree/?.lua"
        package.path = package.path .. ";" .. project_root_dir .. "/config/plugins/nvim-tree/?/init.lua"
        package.path = package.path..";"..project_root_dir.."/config/?.lua"
        -- print(vim.fn.expand(project_root_dir.."/config/?.lua"))
        -- print(project_root_dir.."/config/?.lua")
        
        -- require("nvim_config")
    end
    -- vim.opt.runtimepath:append("/home/angelus/Documents/rps_project/config")
    -- vim.opt.runtimepath:append("/home/angelus/Documents/rps_project/config/plugins")
    -- vim.opt.runtimepath:append("/home/angelus/Documents/rps_project/config/plugins/nvim-tree")
    dofile(project_root_dir.."/config/nvim_config.lua")
    -- require("nvim_config")
else
    print("No nvim_config.lua found.")
end

-- print(package.path.."\n")

vim.cmd("so")