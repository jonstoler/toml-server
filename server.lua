if #arg < 1 then
	error("Must provide a toml file.")
end

local socket = require "socket"
require "toml"

TOML.strict = false
local tbl = {}

local server = assert(socket.tcp())
assert(server:bind("*", 3030))
server:listen(1)

local ip, port = server:getsockname()

local function split(str, delim)
	if str == "" then return {} end
	local result = {}
	for match in (str .. delim):gmatch("(.-)" .. delim) do
		table.insert(result, match)
	end
	return result
end

local running = true
while running do
	local client = server:accept()

	if client then
		local line, err = client:receive()

		if not err then
			local request = split(line, " ")

			if request[1] == "GET" then
				local path = split(request[2], "/")
				table.remove(path, 1)

				local f = io.open(arg[1])
				if not f then
					error("Could not find file " .. arg[1] .. ".")
				end
				local toml = f:read("*a")
				tbl = TOML.parse(toml)

				local special = {
					dump = function() client:send("HTTP/1.0 200 OK\n\n" .. toml) end,
					kill = function() running = false end
				}
				if path[1] == "_" and special[#path > 1 and path[2] or "/"] then
					special[#path > 1 and path[2] or "/"]()
				else
					local obj = tbl
					for k, v in ipairs(path) do
						if v ~= "" then
							if v:match("%d") then v = tonumber(v) end
							if type(obj) == "table" and obj[v] ~= nil then
								obj = obj[v]
							else
								obj = nil
								break
							end
						end
					end

					if obj ~= nil then
						if type(obj) == "table" then
							obj = TOML.encode(obj)
						elseif type(obj) ~= "string" then
							obj = tostring(obj)
						end
						client:send("HTTP/1.0 200 OK\n\n" .. obj)
					end
				end
			end
		end
	end

	client:close()
end
