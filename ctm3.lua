local BASE = "https://raw.githubusercontent.com/9rgh/cstm/main/"

local FILES = {
	"ctm1.lua", 
	"ctm2.lua", 
}


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
