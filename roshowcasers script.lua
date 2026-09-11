--[[
Variables
]]
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
--[[
Slap Battles Group
]]
local GroupId = 9950771
--[[
peoples that are staff ingame
]]
local SBStaff = {
["Trial Staff"] = true,
["Junior Staff"] = true,
["Staff"] = true,
["Senior Staff"] = true,
["Staff Supervisor"] = true,
["Artist"] = true,
["OVERSEER"] = true,
["BOBA"] = true,
["VFX"] = true,
["Builder"] = true,
["Developer"] = true,
["Lead Developer"] = true,
["Owner"] = true
}
--[[
Bypasses Anti Cheats
]]
if ReplicatedStorage.Remotes:FindFirstChild("ModerationRemote") then
ReplicatedStorage.Remotes.ModerationRemote:Destroy()
end
if ReplicatedStorage.Remotes:FindFirstChild("LegacyAntiCheatFunction") then
ReplicatedStorage.Remotes.LegacyAntiCheatFunction:Destroy()
end
if ReplicatedStorage.Remotes:FindFirstChild("Ban") then
ReplicatedStorage.Remotes.Ban:Destroy()
end
if ReplicatedStorage.Remotes:FindFirstChild("LegacyBan") then
ReplicatedStorage.Remotes.LegacyBan:Destroy()
end
if ReplicatedStorage.Remotes:FindFirstChild("KickedBind") then
ReplicatedStorage.Remotes.KickedBind:Destroy()
end
if ReplicatedStorage.Packages:FindFirstChild("HumanoidSpeed") then
ReplicatedStorage.Packages.HumanoidSpeed:Destroy()
end
if ReplicatedStorage:FindFirstChild("ACEventListen") then
ReplicatedStorage.ACEventListen:Destroy()
end
local Version = "1.6.66"
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/download/" .. Version .. "/main.lua"))()
WindUI:AddTheme({
Name = "Ocean Blue",
Accent = Color3.fromHex("#1F4F88"),
Background = Color3.fromHex("#163F78"),
Outline = Color3.fromHex("#4A75A7"),
Text = Color3.fromHex("#F5F8FC"),
Placeholder = Color3.fromHex("#B5C7DC"),
Button = Color3.fromHex("#315D91"),
Icon = Color3.fromHex("#AFCBE8"),
})
WindUI:SetTheme("Ocean Blue")
local Window = WindUI:CreateWindow({
Title = "AWE Hub - Slap Royale",
Icon = "rbxassetid://80728661707224",
IconThemed = false,
Author = "by BaconScripter",
Theme = "Ocean Blue",
Transparent = false,
NewElements = true,
})
--[[
AWE Hub Status
]]
local StatusGreen = Color3.fromHex("#21EF62")
local VersionTag = Window:Tag({
Title = "V1",
Color = StatusGreen,
Radius = 13,
Border = false,
})
local FPSTag = Window:Tag({
Title = "FPS: --",
Color = StatusGreen,
Radius = 13,
Border = false,
})
local PingTag = Window:Tag({
Title = "Ping: --ms",
Color = StatusGreen,
Radius = 13,
Border = false,
})
local Frames = 0
local FPSStarted = os.clock()
RunService.RenderStepped:Connect(function()
Frames += 1
end)
task.spawn(function()
while task.wait(1) do
local Now = os.clock()
local Elapsed = math.max(Now - FPSStarted, 0.001)
local FPS = math.floor((Frames / Elapsed) + 0.5)
Frames = 0
FPSStarted = Now
local Ping = 0
pcall(function()
Ping = math.floor((player:GetNetworkPing() * 1000) + 0.5)
end)
pcall(function()
FPSTag:SetTitle("FPS: " .. tostring(FPS))
end)
pcall(function()
PingTag:SetTitle("Ping: " .. tostring(Ping) .. "ms")
end)
end
end)
local Info = Window:Tab({
Title = "Info",
Icon = "info",
Locked = false,
})
local Game = Window:Tab({
Title = "Game",
Icon = "gamepad-2",
Locked = false,
})
local Welcome = Info:Paragraph({
Title = "@" .. player.Name,
Desc = "Welcome to AWE Hub",
Color = "White",
Image = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420),
ImageSize = 30,
Thumbnail = "",
ThumbnailSize = 80,
Locked = false,
})
local Credits = Info:Paragraph({
Title = "Credits",
Desc = "Owner & Scripter - BaconScripter\nPreviously Owner - screptmaster\n\nthanks for using AWE :)",
Color = "White",
Image = "rbxassetid://80728661707224",
ImageSize = 30,
Thumbnail = "",
ThumbnailSize = 80,
Locked = false,
})
local StaffDetection = Game:Toggle({
Title = "Staff Detetction",
Desc = "Automatically kicks you whenever a staff member is in your game.",
Icon = "bird",
Type = "Checkbox",
Value = false,
Callback = function(Value)
_G.StaffDetetction = Value
while _G.StaffDetetction do
for i, v in pairs(Players:GetPlayers()) do
local role = v:GetRoleInGroup(GroupId)
if SBStaff[role] then
Players.LocalPlayer:Kick("A staff joined the game")
break
end
end
task.wait()
end
end
})
