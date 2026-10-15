--[[
	ctm visuals — loader
	dev by mac (@9rgh) costum visuals

	玩家执行这个就好。
	它会设 SALT_KEY，然后依序载入 ctm1（core）和 ctm2（ui）。
]]

-- ========== 设定 ==========
getgenv().SALT_KEY = "mac-cstm-9rgh"

local BASE = "https://raw.githubusercontent.com/9rgh/cstm/main/"

local FILES = {
	"ctm1.lua", -- core（已混淆）
	"ctm2.lua", -- ui（已混淆）
}

-- ========== 载入 ==========
local function loadRemote(name)
	local url = BASE .. name
	local ok, body = pcall(function()
		return game:HttpGet(url)
	end)
	if not ok or not body or #body < 32 then
		warn("[ctm] failed to download: " .. name)
		return false
	end
	local fn, err = loadstring(body)
	if not fn then
		warn("[ctm] loadstring failed: " .. name .. " — " .. tostring(err))
		return false
	end
	local ok2, err2 = pcall(fn)
	if not ok2 then
		warn("[ctm] runtime error: " .. name .. " — " .. tostring(err2))
		return false
	end
	return true
end

for _, name in ipairs(FILES) do
	if not loadRemote(name) then
		warn("[ctm] stopping loader")
		return
	end
	task.wait(0.15)
end

print("[ctm] loaded")