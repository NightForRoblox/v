
repeat task.wait() until game:IsLoaded()

if shared.vape then 
	shared.vape:Uninject()
end

local cloneref = cloneref or function(obj) return obj end
local playersService = cloneref(game:GetService("Players"))
local lplr = playersService.LocalPlayer
local httpService = cloneref(game:GetService("HttpService"))

local function isfile(p) local s,r=pcall(readfile,p) return s and r and r~="" end
local function downloadFile(path)
	if not isfile(path) then
		local commit = "main"
		local ok, result = pcall(function() return readfile("newvape/profiles/commit.txt") end)
		if ok and result and result ~= "" then commit = result end
		local relativePath = path:gsub("newvape/", "")
		local url = "https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/"..commit.."/"..relativePath
		local res = game:HttpGet(url, true)
		writefile(path, res)
	end
	return readfile(path)
end

if not isfolder("newvape/profiles") then makefolder("newvape/profiles") end
if not isfile("newvape/profiles/gui.txt") then
	  writefile("newvape/profiles/gui.txt", "new")
end
local gui = readfile("newvape/profiles/gui.txt")
local vape = loadstring(downloadFile("newvape/guis/"..gui..".lua"), "gui")()
shared.vape = vape
vape:Load()
