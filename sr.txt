--[[
Variables
]]
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local character = player.Character
local humanoid = character and character:FindFirstChildOfClass("Humanoid")
local humanoidrootpart = character and character:FindFirstChild("HumanoidRootPart")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local antiacid = nil
local antilava = nil
local antilava2 = nil
_G.Glove = false
_G.Kills = false
_G.Power = false
_G.Speed = false
_G.JumpPower = false
local speeddistance = 3
local boostcooldown = 2.5
local tomahawkRange = 20
local Lighting = game:GetService("Lighting")
--[[
Functions
]]
local function GetPlayerInfo(target)
	local character = target.Character
	if not character then return "" end

	local output = {}

	if _G.Glove then
		local glove = target:FindFirstChild("Glove")
		if glove then
			table.insert(output, "Glove: " .. tostring(glove.Value))
		end
	end

	if _G.Kills then
		local kills = character:GetAttribute("Kills")
		if kills ~= nil then
			table.insert(output, "Kills: " .. tostring(kills))
		end
	end

	if _G.Power then
		local power = character:GetAttribute("Power")
		if power ~= nil then
			table.insert(output, "Power: " .. tostring(power))
		end
	end

	if _G.Speed then
		local speed = character:GetAttribute("WalkSpeed")
		if speed ~= nil then
			table.insert(output, "Speed: " .. tostring(speed))
		end
	end

	if _G.JumpPower then
		local jumpPower = character:GetAttribute("JumpPower")
		if jumpPower ~= nil then
			table.insert(output, "JumpPower: " .. tostring(jumpPower))
		end
	end

	return table.concat(output, "\n")
end

local function TP()
	if humanoidrootpart and humanoid then
		local direction = humanoid.MoveDirection

		if direction.Magnitude > 0 then
			direction = direction.Unit

			local boxCFrame, boxSize = character:GetBoundingBox()

			local params = OverlapParams.new()
			params.FilterType = Enum.RaycastFilterType.Exclude
			params.FilterDescendantsInstances = {character}

			local rayParams = RaycastParams.new()
			rayParams.FilterType = Enum.RaycastFilterType.Exclude
			rayParams.FilterDescendantsInstances = {character}

			local result = workspace:Blockcast(boxCFrame, boxSize, direction * speeddistance, rayParams)
			local distance = speeddistance

			if result then
				distance = math.max(result.Distance - 0.5, 0)
			end

			if distance > 0 then
				humanoidrootpart.CFrame += direction * distance
			end
		end
	end
end

local function RemoveZoneEffects()
    local blur = Lighting:FindFirstChild("ZoneBlur")
    local color = Lighting:FindFirstChild("ZoneColorCorrection")
    if blur then
        blur.Enabled = false
    end
    if color then
        color.Enabled = false
    end
end

local function RemoveIceCube()
    for i, v in pairs(character:GetChildren()) do
        if v.Name == "Icecube" then
            v:Destroy()
        end
    end
end

local function DeathCubes(touch)
    for _, v in pairs(workspace:GetDescendants()) do
        if v.Name == "Cube of Death" or v.Name == "Death" then
            v.CanTouch = touch
            v.CanQuery = touch
        end
    end
end
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
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
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
--[[
Wind UI Notification
]]
local function Notification(title, content, duration, icon)
    WindUI:Notify({Title = title, Content = content, Duration = duration, Icon = icon})
end
--[[
Tabs
]]
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
local PlayerMods = Window:Tab({
Title = "Player Mods",
Icon = "gamepad-2",
Locked = false,
})
local Combat = Window:Tab({
Title = "Combat",
Icon = "gamepad-2",
Locked = false,
})
local Immunites = Window:Tab({
Title = "Immunites",
Icon = "gamepad-2",
Locked = false,
})
local ESP = Window:Tab({
Title = "Esp",
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
Title = "Staff Detection",
Desc = "Automatically kicks you whenever a staff member is in your game.",
Icon = "bird",
Type = "Checkbox",
Value = false,
Callback = function(Value)
    _G.StaffDetection = Value
    while _G.StaffDetection do
        for i, v in pairs(Players:GetPlayers()) do
            local role = v:GetRoleInGroup(GroupId)
            if SBStaff[role] then
                player:Kick("A staff joined the game")
                break
            end
        end
        task.wait()
    end
end
})


Game:Divider()

local BunkerCode = Game:Button({
Title = "Get Bunker Code",
Desc = "Shows a notification with bunker code",
Locked = false,
Callback = function()
    if game.Workspace.Map:WaitForChild("CodeBrick").SurfaceGui:FindFirstChild("IMGTemplate") then
        game.Workspace.Map.CodeBrick.SurfaceGui.IMGTemplate.Name = "1st"
        game.Workspace.Map.CodeBrick.SurfaceGui.IMGTemplate.Name = "2nd"
        game.Workspace.Map.CodeBrick.SurfaceGui.IMGTemplate.Name = "3rd"
        game.Workspace.Map.CodeBrick.SurfaceGui.IMGTemplate.Name = "4th"
    end
    local first, second, third, fourth = 0,0,0,0;  
    for i,v in pairs(game.Workspace.Map.CodeBrick.SurfaceGui:GetChildren()) do
        if v.Name == "1st" then
            if v.Image == "http://www.roblox.com/asset/?id=9648769161" then
                first = "4"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648765536" then
                first = "2"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648762863" then
                first = "3"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648759883" then
                first = "9"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648755440" then
                first = "8"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648752438" then
                first = "2"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648749145" then
                first = "8"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648745618" then
                first = "3"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648742013" then
                first = "7"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648738553" then
                first = "8"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648734698" then
                first = "2"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648730082" then
                first = "6"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648723237" then
                first = "3"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648718450" then
                first = "6"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648715920" then
                first = "6"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648712563" then
                first = "2"
            end
        end
    end
    for i,v in pairs(game.Workspace.Map.CodeBrick.SurfaceGui:GetChildren()) do
        if v.Name == "2nd" then
            if v.Image == "http://www.roblox.com/asset/?id=9648769161" then
                second = "4"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648765536" then
                second = "2"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648762863" then
                second = "3"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648759883" then
                second = "9"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648755440" then
                second = "8"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648752438" then
                second = "2"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648749145" then
                second = "8"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648745618" then
                second = "3"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648742013" then
                second = "7"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648738553" then
                second = "8"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648734698" then
                second = "2"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648730082" then
                second = "6"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648723237" then
                second = "3"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648718450" then
                second = "6"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648715920" then
                second = "6"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648712563" then
                second = "2"
            end
        end
    end
    for i,v in pairs(game.Workspace.Map.CodeBrick.SurfaceGui:GetChildren()) do
        if v.Name == "3rd" then
            if v.Image == "http://www.roblox.com/asset/?id=9648769161" then
                third = "4"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648765536" then
                third = "2"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648762863" then
                third = "3"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648759883" then
                third = "9"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648755440" then
                third = "8"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648752438" then
                third = "2"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648749145" then
                third = "8"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648745618" then
                third = "3"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648742013" then
                third = "7"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648738553" then
                third = "8"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648734698" then
                third = "2"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648730082" then
                third = "6"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648723237" then
                third = "3"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648718450" then
                third = "6"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648715920" then
                third = "6"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648712563" then
                third = "2"
            end
        end
    end
    for i,v in pairs(game.Workspace.Map.CodeBrick.SurfaceGui:GetChildren()) do
        if v.Name == "4th" then
            if v.Image == "http://www.roblox.com/asset/?id=9648769161" then
                fourth = "4"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648765536" then
                fourth = "2"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648762863" then
                fourth = "3"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648759883" then
                fourth = "9"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648755440" then
                fourth = "8"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648752438" then
                fourth = "2"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648749145" then
                fourth = "8"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648745618" then
                fourth = "3"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648742013" then
                fourth = "7"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648738553" then
                fourth = "8"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648734698" then
                fourth = "2"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648730082" then
                fourth = "6"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648723237" then
                fourth = "3"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648718450" then
                fourth = "6"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648715920" then
                fourth = "6"
            elseif v.Image == "http://www.roblox.com/asset/?id=9648712563" then
                fourth = "2"
            end
        end
    end
    Notification("Bucker Code", "The code to the bunker is "..first..second..third..fourth, 5, "bird")
end
})


Game:Divider()

local BunkerCode = Game:Button({
    Title = "Rejoin Matchmaking",
    Desc = "Teleports you to a matchmaking server",
    Locked = false,
    Callback = function()
        game:GetService("TeleportService"):Teleport(9426795465)
    end
})

local WalkSpeed = PlayerMods:Toggle({
Title = "WalkSpeed",
Desc = "Increases your speed",
Icon = "bird",
Type = "Checkbox",
Value = false,
Callback = function(Value)
    _G.WalkSpeed = Value
	if connection then
		connection:Disconnect()
		connection = nil
	end
	if Value then
		connection = RunService.Heartbeat:Connect(function()
			local character = player.Character
			local hrp = character and character:FindFirstChild("HumanoidRootPart")
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")
			if not character or character:GetAttribute("Ragdolled") or not hrp or not humanoid then return end
			local move = humanoid.MoveDirection
			if move.Magnitude <= 0 then return end
			local velocity = hrp.AssemblyLinearVelocity
			local horizontal = Vector3.new(velocity.X, 0, velocity.Z)
			local speed = humanoid.WalkSpeed + (tonumber(_G.SpeedValue) or 0)
			if horizontal.Magnitude > speed then
				horizontal = horizontal.Unit * speed
				hrp.AssemblyLinearVelocity = Vector3.new(horizontal.X, velocity.Y, horizontal.Z)
			else
				local direction = Vector3.new(move.X, 0, move.Z).Unit
				hrp.AssemblyLinearVelocity = Vector3.new(direction.X * speed, velocity.Y, direction.Z * speed)
			end
		end)
	end
end
})

local SpeedValue = PlayerMods:Slider({
    Title = "WalkSpeed Value",
    Desc = "",
    Step = 1,
    Value = {
        Min = 1,
        Max = 40,
        Default = 20,
    },
    Callback = function(Value)
        _G.SpeedValue = tonumber(Value) or 0
    end
})

PlayerMods:Divider()

local SpeedBoost = PlayerMods:Toggle({
Title = "Speed Boost",
Desc = "Toggle a TP-Based speed boost",
Icon = "bird",
Type = "Checkbox",
Value = false,
Callback = function(Value)
    _G.SpeedBoost = Value
    while _G.SpeedBoost do
        TP()
        task.wait(boostcooldown)
    end
end
})

local SpeedDistance = PlayerMods:Slider({
    Title = "Distance",
    Desc = "",
    Step = 0.2,
    Value = {
        Min = 5,
        Max = 20,
        Default = 10,
    },
    Callback = function(Value)
        speeddistance = Value
    end
})

local BoostCooldown = PlayerMods:Slider({
    Title = "Cooldown",
    Desc = "low cooldown may kick.",
    Step = 0.1,
    Value = {
        Min = 1,
        Max = 5,
        Default = 2.5,
    },
    Callback = function(Value)
        boostcooldown = Value
    end
})

PlayerMods:Divider()

_G.AntiZoneBlur = false
local AntiZoneBlur = PlayerMods:Toggle({
    Title = "Anti Zone Blur",
    Desc = "Removes the annoying zone blur, so you could see more further.",
    Icon = "bird",
    Type = "Checkbox",
    Value = false,
    Callback = function(Value)
        _G.AntiZoneBlur = Value
        if _G.AntiZoneBlur == true then
            RemoveZoneEffects()
        end
    end
})

Lighting.ChildAdded:Connect(function(zone)
    if not _G.AntiZoneBlur then return end
    if zone.Name == "ZoneBlur" or zone.Name == "ZoneColorCorrection" then
        task.defer(RemoveZoneEffects)
    end
end)

PlayerMods:Divider()

local Hitbox = Combat:Toggle({
Title = "Hitbox",
Desc = "extends players hitbox to make your hits alot easier",
Icon = "bird",
Type = "Checkbox",
Value = false,
Callback = function(Value)
    _G.Hitbox = Value
    if _G.Hitbox == false then
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                v.Character:FindFirstChild("HumanoidRootPart").Size = Vector3.new(2, 2, 1)
                v.Character:FindFirstChild("HumanoidRootPart").Transparency = 1
            end
        end
    end
    while _G.Hitbox do
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                if v.Character:GetAttribute("Vulnerable") and v.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
                    v.Character:FindFirstChild("HumanoidRootPart").Size = Vector3.new(hrpsize, hrpsize, hrpsize)
                    v.Character:FindFirstChild("HumanoidRootPart").Transparency = 0.65
                elseif v.Character:GetAttribute("Ragdolled") and v.Character:GetAttribute("Vulnerable") and v.Character:FindFirstChildOfClass("Humanoid").Health == 0 then
                    v.Character:FindFirstChild("HumanoidRootPart").Size = Vector3.new(2, 2, 1)
                    v.Character:FindFirstChild("HumanoidRootPart").Transparency = 1
                end
            end
        end
        task.wait()
    end
end
})

local HitboxSize = Combat:Slider({
    Title = "Hitbox Size",
    Desc = "",
    Step = 1,
    Value = {
        Min = 5,
        Max = 15,
        Default = 5,
    },
    Callback = function(Value)
        hrpsize = Value
    end
})

Combat:Divider()

local TomahawkAura = Combat:Toggle({
    Title = "Tomahawk Aura",
    Desc = "Hits players within a set distance.",
    Icon = "bird",
    Type = "Checkbox",
    Value = false,
    Callback = function(Value)
        _G.TomahawkAura = Value
        while _G.TomahawkAura do
            if character:FindFirstChild("Tomahawk") then
                for _, v in pairs(Players:GetPlayers()) do
                    if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        if not character:GetAttribute("Ragdolled") and not v.Character:GetAttribute("Ragdolled") and v.Character:GetAttribute("Vulnerable") and not v.Character:FindFirstChild("ForceField") and v.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
                            if (humanoidrootpart.Position - v.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude <= tomahawkRange then
                                ReplicatedStorage.Remotes.Throw:FireServer(Vector3.new(v.Character.HumanoidRootPart.Position))
                            end
                        end
                    end
                end
            end
            task.wait()
        end
    end
})

local TomahawkRange = Combat:Slider({
    Title = "Tomahawk Range",
    Desc = "",
    Step = 1,
    Value = {
        Min = 5,
        Max = 20,
        Default = 20,
    },
    Callback = function(Value)
        tomahawkRange = Value
    end
})

_G.AntiRagdoll = false
local AntiRagdoll = Immunites:Toggle({
Title = "Anti Ragdoll",
Desc = "Remove ragdoll knockback",
Icon = "bird",
Type = "Checkbox",
Value = false,
Callback = function(Value)
    _G.AntiRagdoll = Value
    while _G.AntiRagdoll do
        if character:GetAttribute("Ragdolled") and humanoid.Health > 0 then
           task.spawn(function()
               humanoidrootpart.Massless = true
               task.wait(1)
               humanoidrootpart.Massless = false
            end)
            repeat task.wait() until game:GetService("Players").LocalPlayer.Character:GetAttribute("Ragdolled")
            repeat task.wait()
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
            until not game:GetService("Players").LocalPlayer.Character:GetAttribute("Ragdolled")
        end
        task.wait()
    end
end
})

local AntiAcid = Immunites:Toggle({
Title = "Anti Acid",
Desc = "prevents you from falling into acids whenever you're about to fall",
Icon = "bird",
Type = "Checkbox",
Value = false,
Callback = function(Value)
    _G.AntiAcid = Value
    if _G.AntiAcid == true then
        antiacid = Instance.new("Part",workspace)
        antiacid.Name = "AntiAcid"
        antiacid.CFrame = CFrame.new(-52.5227737, 8.5, -719.113098, 1, 0, 0, 0, 1, 0, 0, 0, 1)
        antiacid.Size = Vector3.new(181, 2, 112)
        antiacid.Transparency = 0.7
        antiacid.Anchored = true
    else
        if antiacid then
            antiacid:Destroy()
            antiacid = nil
        end
    end
end
})

local AntiLava = Immunites:Toggle({
Title = "Anti Lava",
Desc = "prevents you from falling into lavas whenever you're about to fall",
Icon = "bird",
Type = "Checkbox",
Value = false,
Callback = function(Value)
    _G.AntiLava = Value
    if _G.AntiLava == true then
        antilava = Instance.new("Part",workspace)
        antilava.Name = "antilava1"
        antilava.CFrame = CFrame.new(-240.884857, -32.5042801, 387.814423, 1, 0, 0, 0, 1, 0, 0, 0, 1)
        antilava.Size = Vector3.new(145, 1, 164)
        antilava.Transparency = 0.7
        antilava.Anchored = true
        antilava2 = Instance.new("Part",workspace)
        antilava2.Name = "antilava2"
        antilava2.CFrame = CFrame.new(-606.808472, -42.7771835, -224.204117, 1, 0, 0, 0, 1, 0, 0, 0, 1)
        antilava2.Size = Vector3.new(94, 1, 80)
        antilava2.Transparency = 0.7
        antilava2.Anchored = true
    else
        if antilava and antilava2 then
            antilava:Destroy()
            antilava = nil
            antilava2:Destroy()
            antilava2 = nil
        end
    end
end
})

_G.AntiIceCubes = false
local AntiIceCubes = Immunites:Toggle({
Title = "Anti Ice Cubes",
Desc = "Removes your weld to ice cubes.",
Icon = "bird",
Type = "Checkbox",
Value = false,
Callback = function(Value)
    _G.AntiIceCubes = Value
    if _G.AntiIceCubes == true then
        RemoveIceCube()
    end
end
})

character.ChildAdded:Connect(function(cube)
    if not _G.AntiIceCubes then return end
    if cube.Name == "Icecube" then
        task.defer(RemoveIceCube)
    end
end)

local AntiCubeOfDeath = Immunites:Toggle({
Title = "Anti Cube Of Death",
Desc = "prevents you from getting yourself killed from the death cubes",
Icon = "bird",
Type = "Checkbox",
Value = false,
Callback = function(Value)
    _G.AntiCubeOfDeath = Value
    if _G.AntiCubeOfDeath == true then
        DeathCubes(false)
    elseif _G.AntiCubeOfDeath == false then
        DeathCubes(true)
    end 
end
})

local Glove = ESP:Toggle({
Title = "Glove",
Desc = "views what glove the players are using",
Icon = "bird",
Type = "Checkbox",
Value = false,
Callback = function(Value)
    _G.Glove = Value
end
})

local Kills = ESP:Toggle({
Title = "Kills",
Desc = "views how many kills does the players have",
Icon = "bird",
Type = "Checkbox",
Value = false,
Callback = function(Value)
    _G.Kills = Value
end
})

local Power = ESP:Toggle({
Title = "Power",
Desc = "views how much power the players have",
Icon = "bird",
Type = "Checkbox",
Value = false,
Callback = function(Value)
    _G.Power = Value
end
})

local Speed = ESP:Toggle({
Title = "Speed",
Desc = "views how fast is the players",
Icon = "bird",
Type = "Checkbox",
Value = false,
Callback = function(Value)
    _G.Speed = Value
end
})

local JumpPower = ESP:Toggle({
Title = "JumpPower",
Desc = "views how high the players can jump",
Icon = "bird",
Type = "Checkbox",
Value = false,
Callback = function(Value)
    _G.JumpPower = Value
end
})

local PlayersEsp = ESP:Toggle({
Title = "Players ESP",
Desc = "this will make you able to see players from afar",
Icon = "bird",
Type = "Checkbox",
Value = false,
Callback = function(Value)
    _G.PlayersESP = Value
    while _G.PlayersESP do
        for _, e in pairs(Players:GetPlayers()) do
            if e ~= player and e.Character and e.Character:FindFirstChild("HumanoidRootPart") then
                if e.Character:GetAttribute("Vulnerable") and e.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
                    if e.Character:FindFirstChild("Head") and not e.Character.Head:FindFirstChild("ESP") then
                        local billboard = Instance.new("BillboardGui")
                        billboard.Name = "ESP"
                        billboard.Size = UDim2.new(0, 150, 0, 30)
                        billboard.StudsOffset = Vector3.new(0, 2, 0)
                        billboard.AlwaysOnTop = true
                        billboard.Parent = e.Character:FindFirstChild("Head")
                        
                        local label = Instance.new("TextLabel")
                        label.Name = "HeadESP"
                        label.Size = UDim2.fromScale(1, 1)
                        label.BackgroundTransparency = 1
                        label.Text = e.Character.Name .. "\n" .. GetPlayerInfo(e)
                        label.TextScaled = true
                        label.TextColor3 = Color3.new(1, 1, 1)
                        label.TextStrokeTransparency = 0
                        label.Parent = billboard
                    elseif e.Character:FindFirstChild("Head") and e.Character.Head:FindFirstChild("ESP") then
                        e.Character.Head.ESP.HeadESP.Text = GetPlayerInfo(e)
                    end
                end 
            end
        end 
        task.wait()
    end
end
})

ESP:Divider()
