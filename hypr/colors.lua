local defaults = {
	color_background = "0x000000",
	color_foreground = "0x9ccae2",
	color_accent = "0xafa569",
	color_border = "0xafa569",
	color_secondary = "0xafa569",
	color_urgent = "0x1678c3",
	color_muted = "0x6d8d9e",
}

cfg.wal = {}

local f = io.open(os.getenv("HOME") .. "/.cache/wal/hypr.conf")
if f then
	for line in f:lines() do
		local k, v = line:match("%$([%a_]+)%s*=%s*rgb%((%x*)%)")
		if k and v then
			cfg.wal[k] = "0x" .. v
		end
	end
	f:close()
end

for k, v in pairs(defaults) do
	if cfg.wal[k] == nil then
		cfg.wal[k] = v
	end
end
