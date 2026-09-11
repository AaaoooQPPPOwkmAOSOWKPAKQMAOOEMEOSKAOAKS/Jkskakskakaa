--[[
Variables
]]
local Players = game:GetService("Players")
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
if ReplicatedStorage.Remotes:FindFirstChild("LegacyBan")
ReplicatedStorage.Remotes.LegacyBan:Destroy()
end
if ReplicatedStorage.Remotes:FindFirstChild("KickedBind")
ReplicatedStorage.Remotes.KickedBind:Destroy()
end
if ReplicatedStorage.Packages:FindFirstChild("HumanoidSpeed")
ReplicatedStorage.Packages.HumanoidSpeed:Destroy()
end
if ReplicatedStorage:FindFirstChild("ACEventListen")
ReplicatedStorage.ACEventListen:Destroy()
end

local Version = "1.6.66"
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/download/" .. Version .. "/main.lua"))()

WindUI:AddTheme({
Name = "My Theme",
 
Accent = Color3.fromHex("#0F366F"),
Background = Color3.fromHex("#101010"),
Outline = Color3.fromHex("#FFFFFF"),
Text = Color3.fromHex("#FFFFFF"),
Placeholder = Color3.fromHex("#7a7a7a"),
Button = Color3.fromHex("#52525b"),
Icon = Color3.fromHex("#a1a1aa"),
})

WindUI:SetTheme("My Theme")

local Window = WindUI:CreateWindow({
Title = "AWE",
Icon = "rbxassetid://80728661707224",
Author = "by BaconScripter",
})

local Info = Window:Tab({
Title = "Info",
Icon = "bird",
Locked = false,
})

local Game = Window:Tab({
Title = "Game",
Icon = "bird",
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
Desc = "Owner & Scripter - BaconScripter\nPeviously Owner - screptmaster\n\nthanks for using AWE :)",
Color = "White",
Image = "",
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
