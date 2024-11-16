--[[---------------------------------------------------------------------------------------------------------------------------
  __   __     ______     __  __     __     ______     __  __     ______    
 /\ "-.\ \   /\  __ \   /\_\_\_\   /\ \   /\  __ \   /\ \/\ \   /\  ___\   
 \ \ \-.  \  \ \ \/\ \  \/_/\_\/_  \ \ \  \ \ \/\ \  \ \ \_\ \  \ \___  \  
  \ \_\\"\_\  \ \_____\   /\_\/\_\  \ \_\  \ \_____\  \ \_____\  \/\_____\ 
   \/_/ \/_/   \/_____/   \/_/\/_/   \/_/   \/_____/   \/_____/   \/_____/
   
   Made by Team Noxious and Plethora (With additional help from ChatGPT)
   
---------------------------------------------------------------------------------------------------------------------------]]--

wait(0.5)

-------------------------------------------------------------------------------------------------------------------------------

local screengui = Instance.new("ScreenGui")
screengui.Name = "Noxious"
local noxiousbutton = Instance.new("ImageButton")
noxiousbutton.Name = "NoxiousButton"

-------------------------------------------------------------------------------------------------------------------------------

-- screengui.Parent = game:GetService("CoreGui")
screengui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
screengui.ResetOnSpawn = false

-------------------------------------------------------------------------------------------------------------------------------

local clicksound = Instance.new("Sound")
clicksound.SoundId = "rbxassetid://421058925"
clicksound.Parent = noxiousbutton

clicksound.Volume = 0.3

local notifsound = Instance.new("Sound")
notifsound.SoundId = "rbxassetid://8503529139"
notifsound.Parent = noxiousbutton

notifsound.Volume = 0.7

-------------------------------------------------------------------------------------------------------------------------------

local activenotifs = {}

local function notify(message, duration)
	
	local notifframe = Instance.new("Frame")
	notifframe.Size = UDim2.new(0, 300, 0, 80)
	notifframe.Position = UDim2.new(1, 300, 1, -10)
	notifframe.AnchorPoint = Vector2.new(1, 1)
	notifframe.BackgroundColor3 = Color3.new(0, 0, 0)
	notifframe.BackgroundTransparency = 0.2
	notifframe.BorderColor3 = Color3.new(1, 1, 1)
	notifframe.BorderSizePixel = 1
	notifframe.Parent = screengui
	notifframe.ZIndex = 13

	local notiftopframe = Instance.new("Frame")
	notiftopframe.Size = UDim2.new(1, 0, 0, 24)
	notiftopframe.Position = UDim2.new(0, 0, 0, 0)
	notiftopframe.BackgroundColor3 = Color3.new(0, 0, 0)
	notiftopframe.BackgroundTransparency = 0.2
	notiftopframe.BorderColor3 = Color3.new(1, 1, 1)
	notiftopframe.BorderSizePixel = 1
	notiftopframe.Parent = notifframe
	notiftopframe.ZIndex = 14

	local notifytopframetxt = Instance.new("TextLabel")
	notifytopframetxt.Size = UDim2.new(1, -10, 1, 0)
	notifytopframetxt.Position = UDim2.new(0, 5, 0, 0)
	notifytopframetxt.BackgroundTransparency = 1
	notifytopframetxt.TextColor3 = Color3.new(1, 1, 1)
	notifytopframetxt.Text = "Noxious Hub: Dandy's World"
	notifytopframetxt.Font = Enum.Font.Nunito
	notifytopframetxt.TextSize = 21.6
	notifytopframetxt.TextScaled = false
	notifytopframetxt.TextXAlignment = Enum.TextXAlignment.Left
	notifytopframetxt.ZIndex = 15
	notifytopframetxt.Parent = notiftopframe

	local closenotif = Instance.new("TextButton")
	closenotif.Size = UDim2.new(0, 24, 1, 0)
	closenotif.Position = UDim2.new(1, -23, 0, 0)
	closenotif.BackgroundColor3 = Color3.new(1, 0, 0)
	closenotif.BackgroundTransparency = 1
	closenotif.Text = "X"
	closenotif.Font = Enum.Font.Nunito
	closenotif.TextColor3 = Color3.new(1, 1, 1)
	closenotif.TextSize = 20
	closenotif.ZIndex = 16
	closenotif.Parent = notiftopframe
	closenotif.MouseButton1Click:Connect(
		function()
			clicksound:Play()
		end
	)

	local notiftimerframe = Instance.new("Frame")
	notiftimerframe.Size = UDim2.new(0, 301, 0, 6)
	notiftimerframe.Position = UDim2.new(0, -1, 0, 25)
	notiftimerframe.BackgroundColor3 = Color3.new(1, 1, 1)
	notiftimerframe.BorderSizePixel = 0
	notiftimerframe.BackgroundTransparency = 1
	notiftimerframe.Parent = notifframe
	notiftimerframe.ZIndex = 14

	local notiftimer = Instance.new("Frame")
	notiftimer.Size = UDim2.new(1, 0, 1, 0)
	notiftimer.Position = UDim2.new(0, 0, 0, 0)
	notiftimer.BackgroundColor3 = Color3.new(1, 1, 1)
	notiftimer.BorderSizePixel = 0
	notiftimer.BackgroundTransparency = 0.5
	notiftimer.Parent = notiftimerframe
	notiftimer.ZIndex = 15

	local notiftxt = Instance.new("TextLabel")
	notiftxt.Size = UDim2.new(1, -10, 0, 36)
	notiftxt.Position = UDim2.new(0, 10, 0, 36)
	notiftxt.BackgroundTransparency = 1
	notiftxt.TextColor3 = Color3.new(1, 1, 1)
	notiftxt.Text = message
	notiftxt.Font = Enum.Font.Nunito
	notiftxt.TextSize = 21.6
	notiftxt.TextScaled = false
	notiftxt.TextWrapped = true
	notiftxt.TextXAlignment = Enum.TextXAlignment.Left
	notiftxt.ZIndex = 14
	notiftxt.Parent = notifframe

	local tweenService = game:GetService("TweenService")
	local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
	notifsound:Play()

	for i, frame in ipairs(activenotifs) do
		local newTargetPosition = UDim2.new(1, -10, 1, -10 - (i * 90))
		local adjustTween =
			tweenService:Create(
				frame,
				TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{Position = newTargetPosition}
			)
		adjustTween:Play()
	end

	local targetPosition = UDim2.new(1, -10, 1, -10)

	local slideInTween = tweenService:Create(notifframe, tweenInfo, {Position = targetPosition})

	slideInTween:Play()

	table.insert(activenotifs, 1, notifframe)

	local barTweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
	local barTween = tweenService:Create(notiftimer, barTweenInfo, {Size = UDim2.new(0, 0, 1, 0)})
	barTween:Play()

	local function closeNotification()
		barTween:Cancel()

		local slideOutTween =
			tweenService:Create(
				notifframe,
				tweenInfo,
				{Position = UDim2.new(1, 300, notifframe.Position.Y.Scale, notifframe.Position.Y.Offset)}
			)
		slideOutTween:Play()

		slideOutTween.Completed:Connect(
			function()
				notifframe:Destroy()
				for i, frame in ipairs(activenotifs) do
					if frame == notifframe then
						table.remove(activenotifs, i)
						break
					end
				end
				for i, frame in ipairs(activenotifs) do
					local newTargetPosition = UDim2.new(1, -10, 1, -10 - ((i - 1) * 90))
					local adjustTween =
						tweenService:Create(
							frame,
							TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{Position = newTargetPosition}
						)
					adjustTween:Play()
				end
			end
		)
	end

	closenotif.MouseButton1Click:Connect(closeNotification)

	spawn(
		function()
			wait(duration)
			closeNotification()
		end
	)
	closenotif.ZIndex = 20
	notiftimer.ZIndex = 19
	notifytopframetxt.ZIndex = 19
	notiftxt.ZIndex = 18
	notiftimerframe.ZIndex = 18
	notiftopframe.ZIndex = 18
	notifframe.ZIndex = 17
end

-------------------------------------------------------------------------------------------------------------------------------

noxiousbutton.Size = UDim2.new(0, 48, 0, 48)
noxiousbutton.Position = UDim2.new(0.5, -24.5, 1, -350)
noxiousbutton.BorderSizePixel = 0
noxiousbutton.BorderColor3 = Color3.new(1, 1, 1)
noxiousbutton.BorderSizePixel = 1
noxiousbutton.Parent = screengui
noxiousbutton.Image = "rbxassetid://88959546525519"

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0.3, 0)
uiCorner.Parent = noxiousbutton

local borderButton = Instance.new("Frame")
borderButton.Size = UDim2.new(0, 50, 0, 50)
borderButton.Position = UDim2.new(-0.02, 0, -0.02, 0)
borderButton.BackgroundColor3 = Color3.new(1, 1, 1)
borderButton.Parent = noxiousbutton

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0.3, 0)
uiCorner.Parent = borderButton

local UIS = game:GetService('UserInputService')
local frame = noxiousbutton
local dragToggle = nil
local dragSpeed = 0.25
local dragStart = nil
local startPos = nil

local function updatebuttoninput(input)
	local delta = input.Position - dragStart
	local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
		startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	game:GetService('TweenService'):Create(frame, TweenInfo.new(dragSpeed), {Position = position}):Play()
end

frame.InputBegan:Connect(function(input)
	if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
		dragToggle = true
		dragStart = input.Position
		startPos = frame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragToggle = false
			end
		end)
	end
end)

UIS.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		if dragToggle then
			updatebuttoninput(input)
		end
	end
end)

local gradient = Instance.new("UIGradient")
gradient.Color =
	ColorSequence.new {
		ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
		ColorSequenceKeypoint.new(0.5, Color3.new(0, 0, 0)),
		ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1))
	}
gradient.Parent = borderButton

local rotationSpeed = 1
task.spawn(
	function()
		while true do
			gradient.Rotation = (gradient.Rotation + rotationSpeed) % 360
			task.wait(0.03)
		end
	end
)

-------------------------------------------------------------------------------------------------------------------------------

local mainframe = Instance.new("Frame")
mainframe.Size = UDim2.new(0, 540 * 1.1, 0, 300 * 1.1)
mainframe.Position = UDim2.new(0.5, -270 * 1.1, -0.076, 0)
mainframe.BackgroundColor3 = Color3.new(0, 0, 0)
mainframe.BorderSizePixel = 1
mainframe.BorderColor3 = Color3.new(1, 1, 1)
mainframe.BackgroundTransparency = 0.2
mainframe.Parent = screengui
mainframe.Visible = false

local frame = mainframe
local dragToggle = nil
local dragSpeed = 0.25
local dragStart = nil
local startPos = nil

local function updatemainframeinput(input)
	local delta = input.Position - dragStart
	local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
		startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	game:GetService('TweenService'):Create(frame, TweenInfo.new(dragSpeed), {Position = position}):Play()
end

frame.InputBegan:Connect(function(input)
	if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
		dragToggle = true
		dragStart = input.Position
		startPos = frame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragToggle = false
			end
		end)
	end
end)

UIS.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		if dragToggle then
			updatemainframeinput(input)
		end
	end
end)

-------------------------------------------------------------------------------------------------------------------------------

local cmdbar = Instance.new("TextBox")
cmdbar.Size = UDim2.new(0, 270 * 1.1, 0, 48 * 1.1)
cmdbar.Position = UDim2.new(0, 0, 0.7, 54)
cmdbar.PlaceholderText = "Type command here"
cmdbar.Text = ""
cmdbar.Font = Enum.Font.Nunito
cmdbar.TextScaled = true
cmdbar.BackgroundColor3 = Color3.new(0, 0, 0)
cmdbar.TextColor3 = Color3.new(1, 1, 1)
cmdbar.BorderColor3 = Color3.new(1, 1, 1)
cmdbar.BorderSizePixel = 1
cmdbar.TextXAlignment = Enum.TextXAlignment.Left
cmdbar.TextSize = 21.6
cmdbar.TextScaled = false
cmdbar.Parent = mainframe

-------------------------------------------------------------------------------------------------------------------------------

local bottomframe = Instance.new("Frame")
bottomframe.Size = UDim2.new(0, 270 * 1.1, 0, 48 * 1.1)
bottomframe.Position = UDim2.new(0.5, 0, 0.7, 54)
bottomframe.BackgroundColor3 = Color3.new(0, 0, 0)
bottomframe.BorderColor3 = Color3.new(1, 1, 1)
bottomframe.BorderSizePixel = 1
bottomframe.Parent = mainframe

-------------------------------------------------------------------------------------------------------------------------------

local icon = Instance.new("ImageLabel")
icon.Size = UDim2.new(0, 33 * 1.1, 0, 33 * 1.1)
icon.Position = UDim2.new(0.853, 0, 0.1579, 0)
icon.BackgroundTransparency = 0
icon.BackgroundColor3 = Color3.new(0, 0, 0)
icon.BorderSizePixel = 1
icon.BorderColor3 = Color3.new(1, 1, 1)
icon.Image = "rbxassetid://88959546525519"
icon.Parent = bottomframe

-------------------------------------------------------------------------------------------------------------------------------

local hubversion = Instance.new("TextLabel")
hubversion.Size = UDim2.new(0.87 * 1.1, 0, 1 * 1.1, -5.5)
hubversion.Position = UDim2.new(0, -41, 0, 0)
hubversion.BackgroundTransparency = 1
hubversion.TextColor3 = Color3.new(1, 1, 1)
hubversion.Font = Enum.Font.Nunito
hubversion.TextSize = 21.6
hubversion.TextScaled = false
hubversion.Text = "Noxious Hub: Dandy's World"
hubversion.TextXAlignment = Enum.TextXAlignment.Right
hubversion.Parent = bottomframe

-------------------------------------------------------------------------------------------------------------------------------

local padding = Instance.new("UIPadding")
padding.PaddingLeft = UDim.new(0, 13)
padding.Parent = cmdbar

-------------------------------------------------------------------------------------------------------------------------------

local topframe = Instance.new("Frame")
topframe.Size = UDim2.new(0.909 * 1.1, 0, 0, 48 * 1.1)
topframe.BackgroundColor3 = Color3.new(0, 0, 0)
topframe.BorderSizePixel = 0
topframe.BorderColor3 = Color3.new(1, 1, 1)
topframe.BorderSizePixel = 1
topframe.Parent = mainframe

-------------------------------------------------------------------------------------------------------------------------------

local localplayer = game:GetService("Players").LocalPlayer
local welcome = Instance.new("TextLabel")
welcome.Size = UDim2.new(0.5 * 1.1, 0, 1 * 1.1, 0)
welcome.Position = UDim2.new(0.08, 8, 0, -2)
welcome.BackgroundTransparency = 1
welcome.TextColor3 = Color3.new(1, 1, 1)
welcome.Font = Enum.Font.Nunito
welcome.TextSize = 21.6
welcome.TextScaled = false
welcome.Text = "Welcome, " .. localplayer.DisplayName .. " (@" .. localplayer.Name .. ")"
welcome.TextXAlignment = Enum.TextXAlignment.Left
welcome.Parent = topframe

-------------------------------------------------------------------------------------------------------------------------------

local pfp = Instance.new("ImageLabel")
pfp.Size = UDim2.new(0, 33 * 1.1, 0, 33 * 1.1)
pfp.Position = UDim2.new(0.013, 0, 0.158, 0)
pfp.BackgroundTransparency = 0
pfp.BackgroundColor3 = Color3.new(0, 0, 0)
pfp.BorderSizePixel = 1
pfp.BorderColor3 = Color3.new(1, 1, 1)
pfp.Image =
	"https://www.roblox.com/headshot-thumbnail/image?userId=" .. localplayer.UserId .. "&width=420&height=420&format=png"
pfp.Parent = topframe

-------------------------------------------------------------------------------------------------------------------------------

local buttonCommandLists = {
	["ESPs / Visuals"] = {
		"epesp - enables player esp",
		"dpesp - disables player esp",
		" ",
		"mesp - enables machine esp",
		"dmesp - disables machine esp",
		" ",
		"etesp - enables twisteds esp",
		"dtesp - disables twisteds esp",
		" ",
		"eiesp - enables item esp",
		"didesp - disables item esp",
		" ",
		"eesp - enables all esp",
		"desp - disables all esp",
		" ",
		"bstats - break stats",
		" ",
		"sap - show admin panel",
		"hap - hide admin panel",
		" ",
		"epanic - sets panic bool to true",
		"dpanic - sets panic bool to false",
		" ",
		"eloading - sets loading bool to true",
		"dloading - sets loading bool to false",
		" ",
		"evoting - sets voting bool to true",
		"dvoting - sets voting bool to false",
		" ",
		"eil - sets inlobby bool to true",
		"dil - sets inlobby bool to false",
		" ",
		"egnt - enable glitched name tag",
		"dgnt - disable glitched name tag",
		" ",
		"ichor (number) - sets ichor value (CLIENT)",
		" ",
		"uat - unlock all toons (CLIENT)",
	},
	["Map / Environment"] = {
		"efb - enables fullbright",
		"dfb - disables fullbright",
		" ",
		"ddd - delete developer doors",
		"sds - shrimpo decal spam",
		"dib - delete invisible borders / walls",
	},
	["Teleports"] = {
		"tpte - teleport to elevator",
		"eatpte - enables auto tp to elevator",
		"datpte - disables auto tp to elevator",
		" ",
		"dtptg - teleport to a generator",
		"eatptg - enables auto tp to generator",
		"datptg - disables auto tp to generator",
		" ",
		"tptar - teleport to admin room (LOBBY)",
		"tptbr - teleport to bedroom (LOBBY)",
		"tptds - teleport to dandy's shop (LOBBY)",
	},
	["Local Player"] = {
		"eac - enables auto calibration",
		"dac - disables auto calibration",
		" ",
		"tptool - gives you a teleport tool",
		"noclip - enables noclip",
		"ejump - enable jumping",
		"djump - disable jumping",
		" ",
		"ask - anti skillcheck",
		"apu - anti pop-ups",
		"hidenxs - toggles the ui visibility",
		" ",
		"ods - opens dandy's shop",
		"otls - opens toon license shop",
		"ots - opens trinkets shop",
		"oss - opens skins shop",
		"oms - opens merch shop",
		"osc - opens skin changer",
		"oosu - opens old skin unlocker",
		" ",
		"ssh - heal yourself (USE SPROUT)",
		"easa - enable auto boost (USE SHELLY)",
		"dasa - disable shelly auto boost",
	},
	["Fun / Trolls"] = {
		"bang (user) - bangs user",
		"unbang - unbangs user",
		" ",
		"bbang (user) - bottom bangs user",
		"unbbang - unbottom bangs user",
		" ",
		"head (user) - gives user head",
		"unhead - stop giving user head",
		" ",
		"hsit (user) - sit on users head",
		"unhsit - stop sitting on users head",
		" ",
		"hjump (user) - jump on users head",
		"unhjump - stop jumping on users head",
		" ",
		"fdc - fake dandy card",
		"bchar - become yourself (LOBBY)",
		"bd - become dandy (USE BOXTEN) (CLIENT)",
	},
	["Animations / Emotes"] = {
		"agui - opens animations gui",
		" ",
		"therian - makes you crawl",
		"untherian - disables crawling",
		" ",
		"dance - makes you dance",
		"undance - stop dancing",
		" ",
		"hbang - makes you bang your head",
		"unhbang - stop headbanging",
		" ",
		"sit - makes you sit",
		"unsit - stop sitting",
		" ",
		"sit2 - makes you sit v2",
		"unsit2 - stop sitting 2",
		" ",
		"wave - makes you wave",
		"ecwave - enables click to wave",
		"dcwave - disables click to wave",
		" ",
		"dabr - makes you do a barrel roll",
		"ecdabr - enables click to do a barrel roll",
		"dcdabr - disables click to do a barrel roll",
		" ",
		"pounce - makes you pounce",
		"ecpounce - enables click to pounce",
		"dcpounce - disables click to pounce",
		" ",
		"twirl - makes you twirl",
		"ectwirl - enables click to twirl",
		"dctwirl - disables click to twirl",
		" ",
		"twirl2 - makes you twirl v2",
		"ectwirl2 - enables click to twirl v2",
		"dctwirl2 - disables click to twirl v2",
		" ",
		"shimmy - makes you shimmy side to side",
		"ecshimmy - enables click to shimmy side to side",
		"dcshimmy - disables click to shimmy side to side",
		" ",
		"facepalm - makes you facepalm",
		"ecfacepalm - enables click to facepalm",
		"dcfacepalm - disables click to facepalm",
		" ",
		"jump - makes you jump",
		"ecjump - enables click to jump",
		"dcjump - disables click to jump",
		" ",
		"cheer - makes you cheer",
		"eccheer - enables click to cheer",
		"dccheer - disables click to cheer",
		" ",
		"dive - makes you dive",
		"ecdive - enables click to dive",
		"dcdive - disables click to dive"
	},
	["Scripts"] = {
		"bacon - opens Bac0nH1ckOff's script",
		"gobby - opens g0bbyd0llan's script",
		"hex - opens Hex233222's script",
		" ",
		"oldnoxious - opens old noxious hub",
		" ",
		"test - command used for testing, use if you want",
	}
}

-------------------------------------------------------------------------------------------------------------------------------

local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")

local start = Instance.new("TextLabel")
start.Size = UDim2.new(0, 303 * 1.1, 0, 210 * 1.1)
start.Position = UDim2.new(1, -334, 0, 53)
start.TextColor3 = Color3.new(1, 1, 1)
start.BorderColor3 = Color3.new(1,1,1)
start.BackgroundTransparency = 1
start.Font = Enum.Font.Nunito
start.Name = "Introduction"
start.TextSize = 21.6
start.Text = "Press a button on the left to view a list of commands."
start.TextWrapped = true
start.TextXAlignment = Enum.TextXAlignment.Center
start.TextYAlignment = Enum.TextYAlignment.Center
start.Parent = mainframe


local tooltip = Instance.new("Frame")
tooltip.Name = "tooltip"
tooltip.Size = UDim2.new(0, 250 * 1.1, 0, 50 * 1.1)
tooltip.BackgroundTransparency = 1
tooltip.BackgroundColor3 = Color3.new(0, 0, 0)
tooltip.BorderSizePixel = 0
tooltip.Visible = false
tooltip.Parent = mainframe

local tooltipcommand = Instance.new("TextLabel")
tooltipcommand.Name = "CommandName"
tooltipcommand.Size = UDim2.new(1 * 1.1, 0, 0.5 * 1.1, 0)
tooltipcommand.Position = UDim2.new(0, 0, 0, -2.9)
tooltipcommand.BackgroundTransparency = 0
tooltipcommand.BackgroundColor3 = Color3.new(0, 0, 0)
tooltipcommand.TextColor3 = Color3.new(1, 1, 1)
tooltipcommand.Font = Enum.Font.Nunito
tooltipcommand.TextSize = 16
tooltipcommand.TextScaled = false
tooltipcommand.TextWrapped = true
tooltipcommand.BorderSizePixel = 1
tooltipcommand.BorderColor3 = Color3.new(1, 1, 1)
tooltipcommand.TextXAlignment = Enum.TextXAlignment.Center
tooltipcommand.TextYAlignment = Enum.TextYAlignment.Center
tooltipcommand.Parent = tooltip

local tooltipdesc = Instance.new("TextLabel")
tooltipdesc.Name = "Description"
tooltipdesc.Size = UDim2.new(1 * 1.1, 0, 0.5 * 1.1, 0)
tooltipdesc.Position = UDim2.new(0, 0, 0.5, 0)
tooltipdesc.BackgroundTransparency = 0.2
tooltipdesc.BackgroundColor3 = Color3.new(0, 0, 0)
tooltipdesc.TextColor3 = Color3.new(1, 1, 1)
tooltipdesc.Font = Enum.Font.Nunito
tooltipdesc.TextSize = 16
tooltipdesc.TextScaled = false
tooltipdesc.TextWrapped = true
tooltipdesc.BorderSizePixel = 1
tooltipdesc.BorderColor3 = Color3.new(1, 1, 1)
tooltipdesc.TextXAlignment = Enum.TextXAlignment.Center
tooltipdesc.TextYAlignment = Enum.TextYAlignment.Center
tooltipdesc.Parent = tooltip

local function updatetooltipSize(commandName, description)
	local padding = 150
	local totalHeight = 50
	local maxWidth = 100000

	tooltipcommand.Text = commandName
	tooltipdesc.Text = description

	local commandNameWidth = tooltipcommand.TextBounds.X
	local descriptionWidth = tooltipdesc.TextBounds.X

	local newWidth = math.max(commandNameWidth, descriptionWidth) + padding
	tooltip.Size = UDim2.new(0, math.min(newWidth, maxWidth), 0, totalHeight)
end

local hoverDebounce = false
local currentHoverCommand = nil

local function displayCommands(commandList)
	for _, child in ipairs(mainframe:GetChildren()) do
		if child:IsA("TextLabel") and child.Name == "List of commands" then
			child:Destroy()
		elseif child:IsA("TextLabel") and child.Name == "Introduction" then
			child:Destroy()
		elseif child:IsA("TextLabel") and child.Name == "HoverToView" then
			child:Destroy()
		elseif child:IsA("ScrollingFrame") and child.Name == "CommandScrollFrame" then
			child:Destroy()
		end
	end

	local listtitle = Instance.new("TextLabel")
	listtitle.Name = "List of commands"
	listtitle.Size = UDim2.new(0, 298 * 1.1, 0, 36 * 1.1)
	listtitle.Position = UDim2.new(1, -166.5, 0, 46)
	listtitle.AnchorPoint = Vector2.new(0.5, 0)
	listtitle.BackgroundTransparency = 1
	listtitle.TextColor3 = Color3.new(1, 1, 1)
	listtitle.Font = Enum.Font.Nunito
	listtitle.TextSize = 21
	listtitle.BorderSizePixel = 1
	listtitle.BorderColor3 = Color3.new(1, 1, 1)
	listtitle.TextScaled = false
	listtitle.Text = "▼ List of commands ▼"
	listtitle.Parent = mainframe

	local listtitle2 = Instance.new("TextLabel")
	listtitle2.Name = "HoverToView"
	listtitle2.Size = UDim2.new(0, 264 * 1.1, 0, 36 * 1.1)
	listtitle2.Position = UDim2.new(1, -166.5, 0, 64)
	listtitle2.AnchorPoint = Vector2.new(0.5, 0)
	listtitle2.BackgroundTransparency = 1
	listtitle2.TextColor3 = Color3.new(1, 1, 1)
	listtitle2.Font = Enum.Font.Nunito
	listtitle2.TextSize = 15
	listtitle2.BorderSizePixel = 1
	listtitle2.BorderColor3 = Color3.new(1, 1, 1)
	listtitle2.TextScaled = false
	listtitle2.Text = "Hover over a command to view its info."
	listtitle2.Parent = mainframe

	local commandscrollframe = Instance.new("ScrollingFrame")
	commandscrollframe.Name = "CommandScrollFrame"
	commandscrollframe.Size = UDim2.new(0, 299 * 1.1, 0, 174 * 1.1)
	commandscrollframe.Position = UDim2.new(1, -328, 0, 93)
	commandscrollframe.CanvasSize = UDim2.new(0, 0, #commandList * 0, 0)
	commandscrollframe.ScrollBarThickness = 10
	commandscrollframe.BackgroundTransparency = 1
	commandscrollframe.BorderSizePixel = 0
	commandscrollframe.Parent = mainframe
	commandscrollframe.ScrollingDirection = Enum.ScrollingDirection.Y
	commandscrollframe.ScrollBarImageTransparency = 0

	local itemHeight = 15
	local spacing = 1
	local totalHeight = (#commandList * itemHeight) + (#commandList - 1) * spacing

	for i, commandText in ipairs(commandList) do
		local commandtext = Instance.new("TextLabel")
		commandtext.Size = UDim2.new(1 * 1.1, 0, 0, itemHeight * 1.1)
		commandtext.Position = UDim2.new(0, 0, 0, (i - 1) * (itemHeight + spacing))
		commandtext.BackgroundTransparency = 1
		commandtext.TextColor3 = Color3.new(1, 1, 1)
		commandtext.Font = Enum.Font.Nunito
		commandtext.TextSize = 17
		commandtext.TextScaled = false
		commandtext.Text = commandText
		commandtext.BorderSizePixel = 0
		commandtext.TextXAlignment = Enum.TextXAlignment.Left
		commandtext.Parent = commandscrollframe

		commandtext.MouseEnter:Connect(function()
			if not hoverDebounce and commandText and commandText:match("^%s*$") == nil then
				hoverDebounce = true
				currentHoverCommand = commandtext

				local namePart, descriptionPart = commandText:match("^(.-)%s*%-%s*(.*)$")
				namePart = namePart or commandText
				descriptionPart = descriptionPart or ""

				updatetooltipSize(namePart, descriptionPart)

				local mousePosition = userInputService:GetMouseLocation()
				tooltip.Position = UDim2.new(0, mousePosition.X - mainframe.AbsolutePosition.X - (tooltip.Size.X.Offset / 2), 0, mousePosition.Y - mainframe.AbsolutePosition.Y - tooltip.Size.Y.Offset - 82)
				tooltip.Visible = true

				task.delay(0.05, function()
					hoverDebounce = false
				end)
			end
		end)

		commandtext.MouseLeave:Connect(function()
			if currentHoverCommand == commandtext then
				tooltip.Visible = false
				currentHoverCommand = nil
			end
		end)
	end

	commandscrollframe.CanvasSize = UDim2.new(0, 0, 0.017, totalHeight)

	userInputService.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			if tooltip.Visible then
				local mousePosition = input.Position
				tooltip.Position = UDim2.new(0, mousePosition.X - mainframe.AbsolutePosition.X - (tooltip.Size.X.Offset / 2), 0, mousePosition.Y - mainframe.AbsolutePosition.Y - tooltip.Size.Y.Offset - 30)
			end
		end
	end)
end

runService.RenderStepped:Connect(function()
	if currentHoverCommand then
		if not tooltip.Visible then
			tooltip.Visible = true
		end
	else
		tooltip.Visible = false
	end
end)

-------------------------------------------------------------------------------------------------------------------------------

local orderedButtonNames = {
	"ESPs / Visuals",
	"Map / Environment",
	"Teleports",
	"Local Player",
	"Fun / Trolls",
	"Animations / Emotes",
	"Scripts"
}

-------------------------------------------------------------------------------------------------------------------------------

local buttonsframe = Instance.new("ScrollingFrame")
buttonsframe.Size = UDim2.new(0, 237 * 1.1, 0.876 * 1.1, -69.19 * 1.1)
buttonsframe.Position = UDim2.new(0, 0, 0, 48)
buttonsframe.CanvasSize = UDim2.new(0, 0, 1.24, 0)
buttonsframe.ScrollBarThickness = 12
buttonsframe.BackgroundTransparency = 1
buttonsframe.BorderSizePixel = 1
buttonsframe.BorderColor3 = Color3.new(1, 1, 1)
buttonsframe.Parent = mainframe
buttonsframe.ScrollingDirection = Enum.ScrollingDirection.Y
buttonsframe.ScrollBarImageTransparency = 0

-------------------------------------------------------------------------------------------------------------------------------

local scrollbarframe = Instance.new("Frame")
scrollbarframe.Size = UDim2.new(0, 11 * 1.1, 0, 220 * 1.1)
scrollbarframe.BackgroundColor3 = Color3.new(0, 0, 0)
scrollbarframe.BorderSizePixel = 0
scrollbarframe.Position = UDim2.new(0, 248, 0, 48)
scrollbarframe.BorderColor3 = Color3.new(1, 1, 1)
scrollbarframe.BorderSizePixel = 1
scrollbarframe.ZIndex = 1
scrollbarframe.Parent = mainframe

-------------------------------------------------------------------------------------------------------------------------------

local TweenService = game:GetService("TweenService")

local buttonCount = 0
for _, buttonName in ipairs(orderedButtonNames) do
	local commandList = buttonCommandLists[buttonName]

	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1 * 1.1, -50 * 1.1, 0, 45)
	button.Position = UDim2.new(0, 112 * 1.1, buttonCount * 0.137, 33 * 1.1)
	button.AnchorPoint = Vector2.new(0.5, 0.5)
	button.BackgroundColor3 = Color3.new(0, 0, 0)
	button.TextColor3 = Color3.new(1, 1, 1)
	button.Text = buttonName
	button.BorderColor3 = Color3.new(1, 1, 1)
	button.BorderSizePixel = 1
	button.Font = Enum.Font.Nunito
	button.TextSize = 19.2
	button.ZIndex = 17
	button.Parent = buttonsframe

	local defaultSize = button.Size
	local hoverSize = UDim2.new(defaultSize.X.Scale, defaultSize.X.Offset - 5, defaultSize.Y.Scale, defaultSize.Y.Offset - 5)

	local function onHover()
		local hoverTween = TweenService:Create(button, TweenInfo.new(0.2), { Size = hoverSize })
		hoverTween:Play()
	end

	local function onUnhover()
		local unhoverTween = TweenService:Create(button, TweenInfo.new(0.2), { Size = defaultSize })
		unhoverTween:Play()
	end

	button.MouseButton1Click:Connect(
		function()
			clicksound:Play()
			displayCommands(commandList)
		end
	)

	button.MouseEnter:Connect(onHover)
	button.MouseLeave:Connect(onUnhover)

	buttonCount = buttonCount + 1
end

-------------------------------------------------------------------------------------------------------------------------------

local function toggleVisibility()
	mainframe.Visible = not mainframe.Visible
end

noxiousbutton.MouseButton1Click:Connect(
	function()
		toggleVisibility()
		clicksound:Play()
	end
)

-------------------------------------------------------------------------------------------------------------------------------

noxiousbutton.ZIndex = 20
tooltipcommand.ZIndex= 19
tooltipdesc.ZIndex= 19
borderButton.ZIndex = 19
icon.ZIndex = 18
hubversion.ZIndex = 18
tooltip.ZIndex = 18
pfp.ZIndex = 18
welcome.ZIndex = 18
topframe.ZIndex = 18
hubversion.ZIndex = 18
icon.ZIndex = 18
cmdbar.ZIndex = 18
bottomframe.ZIndex = 18
buttonsframe.ZIndex = 17

-------------------------------------------------------------------------------------------------------------------------------

local dandysworld = 16116270224
local dandysworldrun = 16552821455
local dandysworldrp = 18984416148
local testgame = 118022198489171

if game.PlaceId == dandysworld or game.PlaceId == dandysworldrun or game.PlaceId == dandysworldrp or game.PlaceId == testgame then

	-------------------------------------------------------------------------------------------------------------------------------

	print("---------------------------------------------------------------------------")
	print("[:3] Welcome to Noxious Hub: Dandy's World")
	print("[:3] Script is still in development. Expect bugs.")
	print("---------------------------------------------------------------------------")
	print("[:3] Join our discord: https://discord.gg/xZC8zJzF7u")
	print("---------------------------------------------------------------------------")
	print("[:3] Hover over a command to view its info.")
	print("[:3] Some of the commands have not been properly implemented yet.")
	print("---------------------------------------------------------------------------")

	-------------------------------------------------------------------------------------------------------------------------------

	local currentAnimationTrack
	local character = localplayer.Character or localplayer.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")

	local function updateCharacterReferences(newCharacter)
		character = newCharacter
		humanoid = character:WaitForChild("Humanoid")
	end

	localplayer.CharacterAdded:Connect(updateCharacterReferences)

	-------------------------------------------------------------------------------------------------------------------------------

	local function becomeCharacter()
		local Players = game:GetService("Players")
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local speaker = Players.LocalPlayer

		local args = {
			[1] = false
		}
		ReplicatedStorage.Events.UpdateSpawnedIn:FireServer(unpack(args))

		local character = speaker.Character
		local savedCFrame

		if character then
			local rootPart = character:FindFirstChild("HumanoidRootPart")
			if rootPart then
				savedCFrame = rootPart.CFrame
			end
		end

		if character then
			local humanoid = character:FindFirstChildWhichIsA("Humanoid")
			if humanoid then
				humanoid.Health = 0
			end
		end

		speaker.CharacterAdded:Wait()
		local newCharacter = speaker.Character

		if not newCharacter then return end

		local function setupHumanoid()
			local Cam = workspace.CurrentCamera
			local Pos = Cam.CFrame
			local Char = newCharacter
			local Human = Char:FindFirstChildWhichIsA("Humanoid")

			if not Human then return end

			local nHuman = Human:Clone()
			nHuman.Parent = Char
			speaker.Character = nil

			nHuman.BreakJointsOnDeath = true
			nHuman.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None

			Human:Destroy()
			speaker.Character = Char
			Cam.CameraSubject = nHuman
			Cam.CFrame = Pos

			local rootPart = Char:FindFirstChild("HumanoidRootPart")
			if rootPart and savedCFrame then
				rootPart.CFrame = savedCFrame
			end

			local animateScript = Char:FindFirstChild("Animate")
			if animateScript then
				animateScript.Disabled = true
				wait()
				animateScript.Disabled = false
			end

			nHuman.Health = nHuman.MaxHealth
		end

		newCharacter:WaitForChild("Humanoid", 5)
		setupHumanoid()
		
		wait(1)
		
		savedCFrame = nil
	end

	-------------------------------------------------------------------------------------------------------------------------------

	local runservice = game:GetService("RunService")
	local playerplural = game:GetService("Players")

	local highlightLoopRunning = false
	local highlightTypes = {
		Monsters = false,
		Items = false,
		Players = false,
		Machines = false
	}

	local function addHighlights()
		local currentRoom = workspace:FindFirstChild("CurrentRoom")

		-- Highlight monsters
		if highlightTypes.Monsters and currentRoom then
			for _, model in pairs(currentRoom:GetChildren()) do
				local monstersFolder = model:FindFirstChild("Monsters")
				if monstersFolder then
					for _, monster in pairs(monstersFolder:GetChildren()) do
						if monster:IsA("Model") and not monster:FindFirstChildOfClass("Highlight") then
							local highlight = Instance.new("Highlight")
							highlight.FillColor = Color3.fromRGB(255, 0, 0)
							highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
							highlight.Parent = monster
						end
					end
				end
			end
		end

		-- Highlight items
		if highlightTypes.Items and currentRoom then
			for _, model in pairs(currentRoom:GetChildren()) do
				local itemsFolder = model:FindFirstChild("Items")
				if itemsFolder then
					for _, item in pairs(itemsFolder:GetChildren()) do
						if item:IsA("Model") and not item:FindFirstChildOfClass("Highlight") then
							local highlight = Instance.new("Highlight")
							highlight.FillColor = Color3.fromRGB(0, 255, 0)
							highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
							highlight.Parent = item
						end
					end
				end
			end
		end

		-- Highlight players
		if highlightTypes.Players then
			for _, player in pairs(playerplural:GetPlayers()) do
				if player ~= localplayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
					local highlight = player.Character:FindFirstChildOfClass("Highlight")
					if not highlight then
						highlight = Instance.new("Highlight")
						highlight.FillColor = Color3.fromRGB(0, 0, 255)
						highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
						highlight.Parent = player.Character
					end
				end
			end
		end

		-- Highlight machines
		if highlightTypes.Machines and currentRoom then
			for _, model in pairs(currentRoom:GetChildren()) do
				local generatorsFolder = model:FindFirstChild("Generators")
				if generatorsFolder then
					for _, generator in pairs(generatorsFolder:GetChildren()) do
						if generator:IsA("Model") and not generator:FindFirstChildOfClass("Highlight") then
							local highlight = Instance.new("Highlight")
							highlight.FillColor = Color3.fromRGB(130, 130, 130)
							highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
							highlight.Parent = generator
						end
					end
				end
			end
		end
	end

	local function removeHighlights()
		local currentRoom = workspace:FindFirstChild("CurrentRoom")

		-- Remove highlights from monsters, items, and machines
		if currentRoom then
			for _, model in pairs(currentRoom:GetChildren()) do
				for _, folderName in pairs({"Monsters", "Items", "Generators"}) do
					local folder = model:FindFirstChild(folderName)
					if folder then
						for _, obj in pairs(folder:GetChildren()) do
							local highlight = obj:FindFirstChildOfClass("Highlight")
							if highlight then
								highlight:Destroy()
							end
						end
					end
				end
			end
		end

		-- Remove highlights from players
		for _, player in pairs(playerplural:GetPlayers()) do
			if player.Character then
				local highlight = player.Character:FindFirstChildOfClass("Highlight")
				if highlight then
					highlight:Destroy()
				end
			end
		end
	end

	local function startHighlightLoop()
		if highlightLoopRunning then return end
		highlightLoopRunning = true

		runservice.Stepped:Connect(function()
			if highlightLoopRunning then
				addHighlights()
			end
		end)
	end

	local function stopHighlightLoop()
		highlightLoopRunning = false
		removeHighlights()
	end

	-- Functions to enable/disable specific ESP types
	local function enableEsp(type)
		highlightTypes[type] = true
		startHighlightLoop()
	end

	local function disableEsp(type)
		highlightTypes[type] = false

		-- Check if all ESP types are disabled
		local allDisabled = true
		for _, isEnabled in pairs(highlightTypes) do
			if isEnabled then
				allDisabled = false
				break
			end
		end

		if allDisabled then
			stopHighlightLoop()
		else
			removeHighlights()
		end
	end

	-- Function to enable all ESP types
	local function enableAllEsp()
		for type in pairs(highlightTypes) do
			highlightTypes[type] = true
		end
		startHighlightLoop()
	end

	-- Function to disable all ESP types
	local function disableAllEsp()
		for type in pairs(highlightTypes) do
			highlightTypes[type] = false
		end
		stopHighlightLoop()
	end

	-------------------------------------------------------------------------------------------------------------------------------

	local function deleteDeveloperDoors()
		workspace.DevDoor:Destroy()
		wait(0)
		workspace.DevDoor2:Destroy()
	end

	-------------------------------------------------------------------------------------------------------------------------------

	local function fakeDandyCard()
		local args = {
			[1] = "Dandy"
		}

		game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Voted"):InvokeServer(unpack(args))
	end

	-------------------------------------------------------------------------------------------------------------------------------

	local function becomeDandy()

		local dandysworld = 16116270224
		local dandysworldrun = 16552821455

		if game.PlaceId == dandysworldrun then

			local Dandy = game.Workspace.Elevators.Elevator.DandyStore.DandyShop
			local player = game.Players.LocalPlayer
			local character = player.Character or player.CharacterAdded:Wait()
			local DHAir = Dandy.Hair
			local CHAir = character.Hair

			for _, partA in ipairs(Dandy:GetDescendants()) do
				local partB = character:FindFirstChild(partA.Name, true)
				if partB then
					DHAir.Parent = character
					DHAir.Joint.Part0 = character.Head
					wait(0.01)
					character.Animate.idle.Animation1.AnimationId = "rbxassetid://16496520991"
					character.Animate.idle.Animation2.AnimationId = "rbxassetid://16496520991"
					character.Animate.run.RunAnim.AnimationId = "rbxassetid://16496812530"
					character.Config.NormalTexture.Texture = "rbxassetid://16496414911"
					character.Config.HurtTexture.Texture = "rbxassetid://17561468145"

					CHAir:Destroy()
					wait(0.01)
					if partA:IsA("MeshPart") and partB:IsA("MeshPart") then
						local tempMeshId = partA.MeshId
						partA.MeshId = partB.MeshId
						partB.MeshId = tempMeshId
						local tempTextureId = partA.TextureID
						partA.TextureID = partB.TextureID
						partB.TextureID = tempTextureId


					end
					if partA:IsA("SpecialMesh") and partB:IsA("SpecialMesh") then
						local tempMeshId = partA.MeshId
						partA.MeshId = partB.MeshId
						partB.MeshId = tempMeshId
					end
				end
			end
		end

		if game.PlaceId == dandysworld then

			local Dandy = game:GetService("Workspace").DandyStore
			local player = game.Players.LocalPlayer
			local character = player.Character or player.CharacterAdded:Wait()
			local DHAir = game:GetService("Workspace").DandyStore.Hair
			local CHAir = character.Hair

			for _, partA in ipairs(Dandy:GetDescendants()) do
				local partB = character:FindFirstChild(partA.Name, true)
				if partB then
					DHAir.Parent = character
					DHAir.Joint.Part0 = character.Head
					wait(0.01)
					character.Animate.idle.Animation1.AnimationId = "rbxassetid://16496520991"
					character.Animate.idle.Animation2.AnimationId = "rbxassetid://16496520991"
					character.Animate.run.RunAnim.AnimationId = "rbxassetid://16496812530"
					character.Config.NormalTexture.Texture = "rbxassetid://16496414911"
					character.Config.HurtTexture.Texture = "rbxassetid://17561468145"

					CHAir:Destroy()
					wait(0.01)
					if partA:IsA("MeshPart") and partB:IsA("MeshPart") then
						local tempMeshId = partA.MeshId
						partA.MeshId = partB.MeshId
						partB.MeshId = tempMeshId
						local tempTextureId = partA.TextureID
						partA.TextureID = partB.TextureID
						partB.TextureID = tempTextureId


					end
					if partA:IsA("SpecialMesh") and partB:IsA("SpecialMesh") then
						local tempMeshId = partA.MeshId
						partA.MeshId = partB.MeshId
						partB.MeshId = tempMeshId
					end
				end
			end
		end
	end

	-------------------------------------------------------------------------------------------------------------------------------

	local isLooping = false
	local loopConnection
	local originalSettings = {}

	local function saveOriginalSettings()
		local Lighting = game:GetService("Lighting")
		originalSettings.Brightness = Lighting.Brightness
		originalSettings.ClockTime = Lighting.ClockTime
		originalSettings.FogEnd = Lighting.FogEnd
		originalSettings.GlobalShadows = Lighting.GlobalShadows
		originalSettings.OutdoorAmbient = Lighting.OutdoorAmbient
	end

	local function restoreOriginalSettings()
		local Lighting = game:GetService("Lighting")
		Lighting.Brightness = originalSettings.Brightness
		Lighting.ClockTime = originalSettings.ClockTime
		Lighting.FogEnd = originalSettings.FogEnd
		Lighting.GlobalShadows = originalSettings.GlobalShadows
		Lighting.OutdoorAmbient = originalSettings.OutdoorAmbient
	end

	local function fullBright()
		local Lighting = game:GetService("Lighting")
		Lighting.Brightness = 2
		Lighting.ClockTime = 14
		Lighting.FogEnd = 100000
		Lighting.GlobalShadows = false
		Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
	end

	local function enableFullBright()
		if not isLooping then
			isLooping = true
			saveOriginalSettings()
			loopConnection = game:GetService("RunService").RenderStepped:Connect(function()
				fullBright()
			end)
		end
	end

	local function disableFullBright()
		if isLooping then
			isLooping = false
			if loopConnection then
				loopConnection:Disconnect()
				loopConnection = nil
			end
			restoreOriginalSettings()
		end
	end

	-------------------------------------------------------------------------------------------------------------------------------

	local teleportConnections = {}
	local currentAnimationTracks = {}

	local function playAnimation(character, animationId, connectionKey)
		local Anim = Instance.new("Animation")
		Anim.AnimationId = "rbxassetid://" .. animationId

		local humanoid = character:FindFirstChild("Humanoid")
		if humanoid then
			currentAnimationTracks[connectionKey] = humanoid:LoadAnimation(Anim)
			currentAnimationTracks[connectionKey]:Play()
			currentAnimationTracks[connectionKey]:AdjustWeight(999)
			currentAnimationTracks[connectionKey].Looped = true
		end
	end

	local function isAnimationPlaying(character, animationId)
		local humanoid = character:FindFirstChild("Humanoid")
		if humanoid then
			for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
				if track.Animation.AnimationId == "rbxassetid://" .. animationId then
					return true
				end
			end
		end
		return false
	end

	local function teleportBehindTarget(player, targetPlayer, baseOffset, connectionKey)
		local character = player.Character
		local targetCharacter = targetPlayer.Character
		if character and targetCharacter then
			local targetRoot = targetCharacter:FindFirstChild("HumanoidRootPart")
			local playerRoot = character:FindFirstChild("HumanoidRootPart")
			if targetRoot and playerRoot then
				local offset = baseOffset

				-- Apply randomized Y offset only for "dwhsit" and "dwhjump"
				if (connectionKey == "hsit" or connectionKey == "hjump") and isAnimationPlaying(targetCharacter, "16873659196") then
					local yOffset = 3.7 -- Random Y-axis offset between 1 and 5 studs
					offset = CFrame.new(baseOffset.X, yOffset, baseOffset.Z)
				end

				playerRoot.CFrame = targetRoot.CFrame * offset
			end
		end
	end

	local function findPlayerByName(partialName)
		for _, player in ipairs(game.Players:GetPlayers()) do
			if player.Name:lower():sub(1, #partialName) == partialName:lower() then
				return player
			end
		end
		return nil
	end

	local function handleTeleportCommand(command, player, animationId, offset, connectionKey)
		local targetName = command:match("^" .. connectionKey .. "%s+(%S+)$")
		local targetPlayer

		if targetName then
			targetPlayer = findPlayerByName(targetName)
		end

		if targetPlayer then
			playAnimation(player.Character, animationId, connectionKey)

			if teleportConnections[connectionKey] then teleportConnections[connectionKey]:Disconnect() end
			teleportConnections[connectionKey] = game:GetService("RunService").Heartbeat:Connect(function()
				if not targetPlayer.Character or not player.Character then
					teleportConnections[connectionKey]:Disconnect()
					teleportConnections[connectionKey] = nil
					return
				end
				teleportBehindTarget(player, targetPlayer, offset, connectionKey)
			end)
		end
	end

	local function handleStopCommand(connectionKey)
		if teleportConnections[connectionKey] then
			teleportConnections[connectionKey]:Disconnect()
			teleportConnections[connectionKey] = nil
		end

		if currentAnimationTracks[connectionKey] then
			currentAnimationTracks[connectionKey]:Stop()
			currentAnimationTracks[connectionKey] = nil
		end

		local localplayer = game:GetService("Players").LocalPlayer
		local character = localplayer.Character or localplayer.CharacterAdded:Wait()
		local humanoid = character:WaitForChild("Humanoid")

		local animate = character:FindFirstChild("Animate")
		if animate then
			animate.Disabled = true
			for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
				track:Stop()
			end
			animate.Disabled = false
		end
	end

	function dwbang(command, player)
		handleTeleportCommand(command, player, "18213671382", CFrame.new(0, 0, 0.8), "bang")
	end

	function dwunbang()
		handleStopCommand("bang")
	end

	function dwhead(command, player)
		handleTeleportCommand(command, player, "17098030743", CFrame.new(0, -0.35, -1.75) * CFrame.Angles(0, math.pi, 0), "head")
	end

	function dwunhead()
		handleStopCommand("head")
	end

	function dwhsit(command, player)
		handleTeleportCommand(command, player, "16873659196", CFrame.new(0, 4.65, -0.3), "hsit")
	end

	function dwunhsit()
		handleStopCommand("hsit")
	end

	function dwhjump(command, player)
		handleTeleportCommand(command, player, "16909854575", CFrame.new(0, 4.65, -0.3), "hjump")
	end

	function dwunhjsit()
		handleStopCommand("hjump")
	end

	function bottombang(command, player)
		handleTeleportCommand(command, player, "91029796934547", CFrame.new(0, -0.2, -0.9), "bbang")
	end

	function unbottombang()
		handleStopCommand("bbang")
	end

	-------------------------------------------------------------------------------------------------------------------------------

	-- Variables
	local currentAnimationTrack = nil
	local inputConnection

	-- Create Animations
	local BarrelRollAnim = Instance.new("Animation")
	BarrelRollAnim.AnimationId = "rbxassetid://18226927388"

	local WaveAnim = Instance.new("Animation")
	WaveAnim.AnimationId = "rbxassetid://17059625743"

	local TwirlAnim = Instance.new("Animation")
	TwirlAnim.AnimationId = "rbxassetid://17630950280"

	local Twirl2Anim = Instance.new("Animation")
	Twirl2Anim.AnimationId = "rbxassetid://18998583113"

	local CheerAnim = Instance.new("Animation")
	CheerAnim.AnimationId = "rbxassetid://18199893624"

	local ShimmyAnim = Instance.new("Animation")
	ShimmyAnim.AnimationId = "rbxassetid://18155419600"

	local JumpAnim = Instance.new("Animation")
	JumpAnim.AnimationId = "rbxassetid://17295478127"

	local FacepalmAnim = Instance.new("Animation")
	FacepalmAnim.AnimationId = "rbxassetid://73742913578970"

	local PounceAnim = Instance.new("Animation")
	PounceAnim.AnimationId = "rbxassetid://17617839395"

	local DiveAnim = Instance.new("Animation")
	DiveAnim.AnimationId = "rbxassetid://17175061517"

	-- Animation functions
	local function playEmote(animation)
		if currentAnimationTrack then
			currentAnimationTrack:Stop()
		end
		currentAnimationTrack = humanoid:LoadAnimation(animation)
		currentAnimationTrack:Play()
		currentAnimationTrack:AdjustWeight(999)
	end

	-- Animation-specific functions
	local function dwbarrelroll() playEmote(BarrelRollAnim) end
	local function dwwave() playEmote(WaveAnim) end
	local function dwtwirl() playEmote(TwirlAnim) end
	local function dwtwirl2() playEmote(Twirl2Anim) end
	local function dwcheer() playEmote(CheerAnim) end
	local function dwshimmy() playEmote(ShimmyAnim) end
	local function dwjump() playEmote(JumpAnim) end
	local function dwfacepalm() playEmote(FacepalmAnim) end
	local function dwdive() playEmote(DiveAnim) end

	local function disableAnimation()
		if inputConnection then
			inputConnection:Disconnect()
			inputConnection = nil
		end
	end

	-- Functions to enable and disable a specific animation on tap/click
	local function enableAnimation(animationFunction)
		disableAnimation() -- Ensure no existing input connection
		inputConnection = userInputService.InputBegan:Connect(function(input, gameProcessed)
			if gameProcessed then return end
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				animationFunction()
			end
		end)
	end

	-------------------------------------------------------------------------------------------------------------------------------

	local function dwhbang(command)

		local HeadbangAnim = Instance.new("Animation")
		HeadbangAnim.AnimationId = "rbxassetid://17561277632"

		local humanoid = localplayer.Character and localplayer.Character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			if currentAnimationTrack then
				currentAnimationTrack:Stop()
			end

			currentAnimationTrack = humanoid:LoadAnimation(HeadbangAnim)
			currentAnimationTrack:Play()

			currentAnimationTrack:AdjustWeight(999)
		end
	end

	localplayer.CharacterAdded:Connect(function(character)
		local humanoid = character:WaitForChild("Humanoid")
	end)

	-------------------------------------------------------------------------------------------------------------------------------

	local function dwdance(command)

		local DanceAnim = Instance.new("Animation")
		DanceAnim.AnimationId = "rbxassetid://17516071317"

		local humanoid = localplayer.Character and localplayer.Character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			if currentAnimationTrack then
				currentAnimationTrack:Stop()
			end

			currentAnimationTrack = humanoid:LoadAnimation(DanceAnim)
			currentAnimationTrack:Play()

			currentAnimationTrack:AdjustWeight(999)
		end
	end

	localplayer.CharacterAdded:Connect(function(character)
		local humanoid = character:WaitForChild("Humanoid")
	end)

	-------------------------------------------------------------------------------------------------------------------------------

	local function dwtherian(command)

		local TherianAnim = Instance.new("Animation")
		TherianAnim.AnimationId = "rbxassetid://91029796934547"

		local humanoid = localplayer.Character and localplayer.Character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			if currentAnimationTrack then
				currentAnimationTrack:Stop()
			end

			currentAnimationTrack = humanoid:LoadAnimation(TherianAnim)
			currentAnimationTrack:Play()

			currentAnimationTrack:AdjustWeight(999)
		end
	end

	localplayer.CharacterAdded:Connect(function(character)
		local humanoid = character:WaitForChild("Humanoid")
	end)

	-------------------------------------------------------------------------------------------------------------------------------

	local function dwsit(command)

		local SitAnim = Instance.new("Animation")
		SitAnim.AnimationId = "rbxassetid://18989418012"

		local humanoid = localplayer.Character and localplayer.Character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			if currentAnimationTrack then
				currentAnimationTrack:Stop()
			end

			currentAnimationTrack = humanoid:LoadAnimation(SitAnim)
			currentAnimationTrack:Play()

			currentAnimationTrack:AdjustWeight(999)
		end
	end

	localplayer.CharacterAdded:Connect(function(character)
		local humanoid = character:WaitForChild("Humanoid")
	end)

	-------------------------------------------------------------------------------------------------------------------------------

	local function dwpounce(command)

		local PounceAnim = Instance.new("Animation")
		PounceAnim.AnimationId = "rbxassetid://17617839395"

		local humanoid = localplayer.Character and localplayer.Character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			if currentAnimationTrack then
				currentAnimationTrack:Stop()
			end

			currentAnimationTrack = humanoid:LoadAnimation(PounceAnim)
			currentAnimationTrack:Play()

			currentAnimationTrack:AdjustWeight(999)
		end
	end

	localplayer.CharacterAdded:Connect(function(character)
		local humanoid = character:WaitForChild("Humanoid")
	end)

	-------------------------------------------------------------------------------------------------------------------------------

	local function dwsit2(command)

		local Sit2Anim = Instance.new("Animation")
		Sit2Anim.AnimationId = "rbxassetid://16873659196"

		local humanoid = localplayer.Character and localplayer.Character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			if currentAnimationTrack then
				currentAnimationTrack:Stop()
			end

			currentAnimationTrack = humanoid:LoadAnimation(Sit2Anim)
			currentAnimationTrack:Play()

			currentAnimationTrack:AdjustWeight(999)
		end
	end

	localplayer.CharacterAdded:Connect(function(character)
		local humanoid = character:WaitForChild("Humanoid")
	end)

	-------------------------------------------------------------------------------------------------------------------------------

	localplayer.CharacterAdded:Connect(updateCharacterReferences)

	local function dwunhbang(command)
		local Char = localplayer.Character or localplayer.CharacterAdded:Wait()
		local Human = Char and Char:WaitForChild("Humanoid", 15)
		local Animate = Char and Char:WaitForChild("Animate", 15)

		if Animate then
			Animate.Disabled = true
			for _, v in ipairs(Human:GetPlayingAnimationTracks()) do
				v:Stop()
			end
			Animate.Disabled = false
		end
	end

	-------------------------------------------------------------------------------------------------------------------------------

	localplayer.CharacterAdded:Connect(updateCharacterReferences)

	local function dwunsit2(command)
		local Char = localplayer.Character or localplayer.CharacterAdded:Wait()
		local Human = Char and Char:WaitForChild("Humanoid", 15)
		local Animate = Char and Char:WaitForChild("Animate", 15)

		if Animate then
			Animate.Disabled = true
			for _, v in ipairs(Human:GetPlayingAnimationTracks()) do
				v:Stop()
			end
			Animate.Disabled = false
		end
	end

	-------------------------------------------------------------------------------------------------------------------------------

	localplayer.CharacterAdded:Connect(updateCharacterReferences)

	local function dwundance(command)
		local Char = localplayer.Character or localplayer.CharacterAdded:Wait()
		local Human = Char and Char:WaitForChild("Humanoid", 15)
		local Animate = Char and Char:WaitForChild("Animate", 15)

		if Animate then
			Animate.Disabled = true
			for _, v in ipairs(Human:GetPlayingAnimationTracks()) do
				v:Stop()
			end
			Animate.Disabled = false
		end
	end

	-------------------------------------------------------------------------------------------------------------------------------

	localplayer.CharacterAdded:Connect(updateCharacterReferences)

	local function dwuntherian(command)
		local Char = localplayer.Character or localplayer.CharacterAdded:Wait()
		local Human = Char and Char:WaitForChild("Humanoid", 15)
		local Animate = Char and Char:WaitForChild("Animate", 15)

		if Animate then
			Animate.Disabled = true
			for _, v in ipairs(Human:GetPlayingAnimationTracks()) do
				v:Stop()
			end
			Animate.Disabled = false
		end
	end

	-------------------------------------------------------------------------------------------------------------------------------

	localplayer.CharacterAdded:Connect(updateCharacterReferences)

	local function dwunsit(command)
		local Char = localplayer.Character or localplayer.CharacterAdded:Wait()
		local Human = Char and Char:WaitForChild("Humanoid", 15)
		local Animate = Char and Char:WaitForChild("Animate", 15)

		if Animate then
			Animate.Disabled = true
			for _, v in ipairs(Human:GetPlayingAnimationTracks()) do
				v:Stop()
			end
			Animate.Disabled = false
		end
	end

	-------------------------------------------------------------------------------------------------------------------------------
	
	local function sproutselfheal()
		local args = {
			[1] = game:GetService("Players").LocalPlayer.Character,
			[2] = CFrame.new(-179.29843139648438, 146.2311248779297, -164.61495971679688) * CFrame.Angles(3.1415927410125732, 0.4017193913459778, -3.141592502593994),
			[3] = game:GetService("Players").LocalPlayer.Character
		}

		game:GetService("ReplicatedStorage").Events.AbilityEvent:InvokeServer(unpack(args))
	end
	
	-------------------------------------------------------------------------------------------------------------------------------
	
	local function breakstats()
		local inGamePlayersFolder = game.Workspace:FindFirstChild("InGamePlayers")

		if inGamePlayersFolder then
			for _, playerFolder in pairs(inGamePlayersFolder:GetChildren()) do
				local statsFolder = playerFolder:FindFirstChild("Stats")

				if statsFolder then
					for _, stat in pairs(statsFolder:GetChildren()) do
						if stat:IsA("NumberValue") then
							stat.Value = "nan"
						end
					end
				end
			end
		end
	end

	-------------------------------------------------------------------------------------------------------------------------------

	local teleportEnabled = true
	local heartbeatConnection

	local function dweatpte()
		local workspace = game:GetService("Workspace")
		local runService = game:GetService("RunService")
		local infoFolder = workspace:FindFirstChild("Info")
		if infoFolder then
			local panicBool = infoFolder:FindFirstChild("Panic")
			if panicBool and panicBool:IsA("BoolValue") then
				if not heartbeatConnection or heartbeatConnection.Connected == false then
					heartbeatConnection = runService.Heartbeat:Connect(function()
						if teleportEnabled and panicBool.Value == true then
							local elevatorsFolder = workspace:FindFirstChild("Elevators")
							if elevatorsFolder then
								local elevatorModel = elevatorsFolder:FindFirstChildWhichIsA("Model")
								if elevatorModel then
									local monsterBlocker = elevatorModel:FindFirstChild("MonsterBlocker")
									if monsterBlocker and monsterBlocker:IsA("Part") then
										local character = game.Players.LocalPlayer.Character
										if character and character:FindFirstChild("HumanoidRootPart") then
											character.HumanoidRootPart.CFrame = monsterBlocker.CFrame
										end
									end
								end
							end
						end
					end)
				end
			end
		end
	end

	local function dwdatpte()
		teleportEnabled = false
		if heartbeatConnection then
			heartbeatConnection:Disconnect()
		end
	end

	-------------------------------------------------------------------------------------------------------------------------------

	local function dwtptg()
		local currentRoom = workspace:FindFirstChild("CurrentRoom")
		local character = localplayer.Character or localplayer.CharacterAdded:Wait()

		if currentRoom then
			for _, item in pairs(currentRoom:GetChildren()) do
				if item:IsA("Model") then
					local generatorsFolder = item:FindFirstChild("Generators")

					if generatorsFolder then
						local generators = {}

						for _, generator in pairs(generatorsFolder:GetChildren()) do
							if generator:IsA("Model") and generator.PrimaryPart then
								local statsFolder = generator:FindFirstChild("Stats")
								if statsFolder then
									local completedValue = statsFolder:FindFirstChild("Completed")
									if completedValue and completedValue:IsA("BoolValue") and not completedValue.Value then
										table.insert(generators, generator)
									end
								end
							end
						end

						if #generators > 0 then
							local randomGenerator = generators[math.random(1, #generators)]
							local generatorCFrame = randomGenerator:GetPrimaryPartCFrame()

							local forwardPosition = generatorCFrame.Position + generatorCFrame.LookVector * 4
							local targetCFrame = CFrame.new(forwardPosition, generatorCFrame.Position)

							character:SetPrimaryPartCFrame(targetCFrame)
						end
					end
				end
			end
		end
	end

	local checkLoopRunning = false  -- Flag to control the loop

	local function checkNearestGenerator()
		while checkLoopRunning do  -- Loop only runs if the flag is true
			local currentRoom = workspace:FindFirstChild("CurrentRoom")
			if currentRoom and character and character:FindFirstChild("HumanoidRootPart") then
				local closestGenerator = nil
				local closestDistance = math.huge

				for _, item in pairs(currentRoom:GetChildren()) do
					local generatorsFolder = item:FindFirstChild("Generators")
					if generatorsFolder then
						for _, generator in pairs(generatorsFolder:GetChildren()) do
							if generator:IsA("Model") and generator.PrimaryPart then
								local distance = (generator.PrimaryPart.Position - character.HumanoidRootPart.Position).Magnitude
								if distance < closestDistance then
									closestDistance = distance
									closestGenerator = generator
								end
							end
						end
					end
				end

				if closestGenerator then
					local statsFolder = closestGenerator:FindFirstChild("Stats")
					if statsFolder then
						local completedValue = statsFolder:FindFirstChild("Completed")
						if completedValue and completedValue:IsA("BoolValue") and completedValue.Value == true then
							dwtptg()
						end
					end
				end
			end
			wait(1)
		end
	end

	-- Function to start the loop
	local function startCheckLoop()
		if not checkLoopRunning then
			checkLoopRunning = true
			spawn(checkNearestGenerator)  -- Run the function in a new thread
		end
	end

	-- Function to stop the loop
	local function stopCheckLoop()
		checkLoopRunning = false
	end

	-------------------------------------------------------------------------------------------------------------------------------

	local function dwtpte()
		local elevatorsFolder = workspace:FindFirstChild("Elevators")

		if elevatorsFolder then
			local elevatorModel = elevatorsFolder:FindFirstChildWhichIsA("Model")

			if elevatorModel then
				local monsterBlocker = elevatorModel:FindFirstChild("MonsterBlocker")

				if monsterBlocker and monsterBlocker:IsA("Part") then
					local character = localplayer.Character
					if character and character:FindFirstChild("HumanoidRootPart") then
						character.HumanoidRootPart.CFrame = monsterBlocker.CFrame
					end
				end
			end
		end
	end

	-------------------------------------------------------------------------------------------------------------------------------

	local function dwshrimpdecal()
		local function replacealltextures(root)
			for _, v in pairs(root:GetChildren()) do
				if v:IsA("Decal") and v.Texture ~= "rbxassetid://97212326743600" then
					v.Parent = nil
				elseif v:IsA("BasePart") then
					v.Material = "Plastic"
					local One = Instance.new("Decal", v)
					local Two = Instance.new("Decal", v)
					local Three = Instance.new("Decal", v)
					local Four = Instance.new("Decal", v)
					local Five = Instance.new("Decal", v)
					local Six = Instance.new("Decal", v)
					One.Texture = "rbxassetid://97212326743600"
					Two.Texture = "rbxassetid://97212326743600"
					Three.Texture = "rbxassetid://97212326743600"
					Four.Texture = "rbxassetid://97212326743600"
					Five.Texture = "rbxassetid://97212326743600"
					Six.Texture = "rbxassetid://97212326743600"
					One.Face = "Front"
					Two.Face = "Back"
					Three.Face = "Right"
					Four.Face = "Left"
					Five.Face = "Top"
					Six.Face = "Bottom"
				end
				replacealltextures(v)
			end
		end
		local function applytextures(root)
			for _, v in pairs(root:GetChildren()) do
				applytextures(v)
			end
		end
		replacealltextures(game.Workspace)
		applytextures(game.Workspace)
		
		local lighting = game:GetService("Lighting")

		local sky = lighting:FindFirstChildOfClass("Sky") or Instance.new("Sky")

		sky.SkyboxBk = "rbxassetid://97212326743600"
		sky.SkyboxDn = "rbxassetid://97212326743600"
		sky.SkyboxFt = "rbxassetid://97212326743600"
		sky.SkyboxLf = "rbxassetid://97212326743600"
		sky.SkyboxRt = "rbxassetid://97212326743600"
		sky.SkyboxUp = "rbxassetid://97212326743600"
	end

	-------------------------------------------------------------------------------------------------------------------------------

	local function bacondwscript()
		pcall(function()
			loadstring(game:HttpGet("https://raw.githubusercontent.com/Bac0nHck/Scripts/main/Dandy's%20World"))("t.me/arceusxscripts")
		end)
	end

	local function g0bbydwscript()
		loadstring(game:HttpGet("https://pastebin.com/raw/QQt4pVtu"))() 
	end

	local function oldnoxious()
		loadstring(game:HttpGet("https://pastebin.com/raw/gZ3940Ti"))() 
	end

	local function hexdwscript()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Hexitopixel/Todosk/refs/heads/main/Skibid"))()	
	end

	-------------------------------------------------------------------------------------------------------------------------------

	local function test()
		local function test2(root)
			for _, v in pairs(root:GetChildren()) do
				if v:IsA("Decal") and v.Texture ~= "rbxassetid://70931990930559" then
					v.Parent = nil
				elseif v:IsA("BasePart") then
					v.Material = "Plastic"
					local One = Instance.new("Decal", v)
					local Two = Instance.new("Decal", v)
					local Three = Instance.new("Decal", v)
					local Four = Instance.new("Decal", v)
					local Five = Instance.new("Decal", v)
					local Six = Instance.new("Decal", v)
					One.Texture = "rbxassetid://70931990930559"
					Two.Texture = "rbxassetid://70931990930559"
					Three.Texture = "rbxassetid://70931990930559"
					Four.Texture = "rbxassetid://70931990930559"
					Five.Texture = "rbxassetid://70931990930559"
					Six.Texture = "rbxassetid://70931990930559"
					One.Face = "Front"
					Two.Face = "Back"
					Three.Face = "Right"
					Four.Face = "Left"
					Five.Face = "Top"
					Six.Face = "Bottom"
				end
				test2(v)
			end
		end
		local function test3(root)
			for _, v in pairs(root:GetChildren()) do
				test3(v)
			end
		end
		test2(game.Workspace)
		test3(game.Workspace)

		local function replaceTextInGui(guiObject)
			if guiObject:IsA("TextLabel") or guiObject:IsA("TextButton") then
				guiObject.Text = "noxious ot"
			end
		end

		local function replaceTextInWorkspace()
			for _, obj in pairs(workspace:GetDescendants()) do
				if obj:IsA("BillboardGui") or obj:IsA("SurfaceGui") then
					for _, child in pairs(obj:GetDescendants()) do
						replaceTextInGui(child)
					end
				end
			end
		end

		replaceTextInWorkspace()

		for _, gui in pairs(game.Players.LocalPlayer.PlayerGui:GetDescendants()) do
			replaceTextInGui(gui)
		end

		local imageId = "rbxassetid://70931990930559"

		local function createBillboardGui(part)
			if part:FindFirstChildOfClass("BillboardGui") then return end

			local billboardGui = Instance.new("BillboardGui")
			billboardGui.Size = UDim2.new(3, 0, 3, 0)
			billboardGui.AlwaysOnTop = true
			billboardGui.Parent = part
			billboardGui.Adornee = part

			local imageLabel = Instance.new("ImageLabel")
			imageLabel.Size = UDim2.new(1, 0, 1, 0)
			imageLabel.Image = imageId
			imageLabel.BackgroundTransparency = 1
			imageLabel.Parent = billboardGui
		end

		local function addBillboardGuis()
			for _, descendant in pairs(workspace:GetDescendants()) do
				if descendant:IsA("BasePart") then
					createBillboardGui(descendant)
				end
			end

			workspace.DescendantAdded:Connect(function(newDescendant)
				if newDescendant:IsA("BasePart") then
					createBillboardGui(newDescendant)
				end
			end)
		end

		addBillboardGuis()

		local lighting = game:GetService("Lighting")

		local sky = lighting:FindFirstChildOfClass("Sky") or Instance.new("Sky")

		sky.SkyboxBk = "rbxassetid://70931990930559"
		sky.SkyboxDn = "rbxassetid://70931990930559"
		sky.SkyboxFt = "rbxassetid://70931990930559"
		sky.SkyboxLf = "rbxassetid://70931990930559"
		sky.SkyboxRt = "rbxassetid://70931990930559"
		sky.SkyboxUp = "rbxassetid://70931990930559"

		sky.Parent = lighting
	end

	-------------------------------------------------------------------------------------------------------------------------------

	local function tptoadminroom()
		local character = localplayer.Character or localplayer.CharacterAdded:Wait()
		local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
		local targetPosition = Vector3.new(-43, 21, 24)
		humanoidRootPart.CFrame = CFrame.new(targetPosition)
	end

	-------------------------------------------------------------------------------------------------------------------------------

	local function tptobedroom()
		local character = localplayer.Character or localplayer.CharacterAdded:Wait()
		local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
		local targetPosition = Vector3.new(-175, 8, 49)
		humanoidRootPart.CFrame = CFrame.new(targetPosition)
	end

	-------------------------------------------------------------------------------------------------------------------------------

	local function tptodandysshop()
		local character = localplayer.Character or localplayer.CharacterAdded:Wait()
		local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
		local targetPosition = Vector3.new(-19, 21, 17)
		humanoidRootPart.CFrame = CFrame.new(targetPosition)
	end

	-------------------------------------------------------------------------------------------------------------------------------

	local function animationsgui()
		loadstring(game:HttpGet("https://pastebin.com/raw/xELCnKuC"))()
	end

	-------------------------------------------------------------------------------------------------------------------------------

	local function enablepanic()
		local panicValue = workspace:FindFirstChild("Info"):FindFirstChild("Panic")

		if panicValue and panicValue:IsA("BoolValue") then
			panicValue.Value = true
		end
	end

	local function disablepanic()
		local panicValue = workspace:FindFirstChild("Info"):FindFirstChild("Panic")

		if panicValue and panicValue:IsA("BoolValue") then
			panicValue.Value = false
		end
	end

	-------------------------------------------------------------------------------------------------------------------------------

	local function enablevoting()
		local votingValue = workspace:FindFirstChild("Info"):FindFirstChild("Voting")

		if votingValue and votingValue:IsA("BoolValue") then
			votingValue.Value = true
		end
	end

	local function disablevoting()
		local votingValue = workspace:FindFirstChild("Info"):FindFirstChild("Voting")

		if votingValue and votingValue:IsA("BoolValue") then
			votingValue.Value = false
		end
	end

	-------------------------------------------------------------------------------------------------------------------------------

	local function enableloading()
		local playergui = localplayer:FindFirstChild("PlayerGui")
		local maingui = playergui:FindFirstChild("MainGui")

		if maingui then
			local lobbyloading = maingui:FindFirstChild("Loading")
			if lobbyloading and lobbyloading:IsA("BoolValue") then
				lobbyloading.Value = true
			end
		end
		
		local runloading = workspace:FindFirstChild("Info"):FindFirstChild("Loading")
		if runloading and runloading:IsA("BoolValue") then
			runloading.Value = true
		end
	end

	local function disableloading()
		local playergui = localplayer:WaitForChild("PlayerGui")
		local maingui = playergui:FindFirstChild("MainGui")

		if maingui then
			local lobbyloading = maingui:FindFirstChild("Loading")
			if lobbyloading and lobbyloading:IsA("BoolValue") then
				lobbyloading.Value = false
			end
		end
		
		local runloading = workspace:FindFirstChild("Info"):FindFirstChild("Loading")
		if runloading and runloading:IsA("BoolValue") then
			runloading.Value = false
		end
	end

	-------------------------------------------------------------------------------------------------------------------------------

	local function enableinlobby()
		local player = game.Players.LocalPlayer
		local playerName = player.Name
		local playersFolder = workspace:FindFirstChild("Players")

		if playersFolder then
			local playerModel = playersFolder:FindFirstChild(playerName)
			if playerModel then
				local inLobbyValue = playerModel:FindFirstChild("InLobby")
				if inLobbyValue and inLobbyValue:IsA("BoolValue") then
					inLobbyValue.Value = true
				end
			end
		end
	end

	local function disableinlobby()
		local player = game.Players.LocalPlayer
		local playerName = player.Name
		local playersFolder = workspace:FindFirstChild("Players")

		if playersFolder then
			local playerModel = playersFolder:FindFirstChild(playerName)
			if playerModel then
				local inLobbyValue = playerModel:FindFirstChild("InLobby")
				if inLobbyValue and inLobbyValue:IsA("BoolValue") then
					inLobbyValue.Value = false
				end
			end
		end
	end

	-------------------------------------------------------------------------------------------------------------------------------
	
	local function showgui(parent)
		for _, child in ipairs(parent:GetChildren()) do
			if child:IsA("GuiObject") then
				child.Visible = true
			end
			showgui(child)
		end
	end

	local function hidegui(parent)
		for _, child in ipairs(parent:GetChildren()) do
			if child:IsA("GuiObject") then
				child.Visible = true
			end
			hidegui(child)
		end
	end

	local function showadminpanel()
		local devframe = game.ReplicatedStorage.Admin.DevFrame
		devframe.Frame.Visible = true
		devframe.Frame.Parent = game.Players.LocalPlayer.PlayerGui.MainGui
		
		local function showadminpanel2()
			if localplayer and localplayer:FindFirstChild("PlayerGui") then
				for _, screenGui in ipairs(localplayer.PlayerGui:GetChildren()) do
					if screenGui:IsA("ScreenGui") then
						local devFrame = screenGui:FindFirstChild("DevFrame")
						if devFrame and devFrame:IsA("Frame") then
							devFrame.Visible = true
							showgui(devFrame)
						end
					end
				end
			end
		end
		showadminpanel2()
	end

	local function hideadminpanel()
		local devframe = game.Players.LocalPlayer.PlayerGui.MainGui
		devframe.Frame.Visible = false
		devframe.Frame.Parent = game.ReplicatedStorage.Admin.DevFrame
		
		local function hideadminpanel2()
			if localplayer and localplayer:FindFirstChild("PlayerGui") then
				for _, screenGui in ipairs(localplayer.PlayerGui:GetChildren()) do
					if screenGui:IsA("ScreenGui") then
						local devFrame = screenGui:FindFirstChild("DevFrame")
						if devFrame and devFrame:IsA("Frame") then
							devFrame.Visible = true
							hidegui(devFrame)
						end
					end
				end
			end
		end
		hideadminpanel2()
	end
	
	-------------------------------------------------------------------------------------------------------------------------------

	-- Variable to control the loop
	local loopEnabled = false

	-- Function to start the loop
	local function startLoop()
		local player = game.Players.LocalPlayer
		local playerModel = workspace:FindFirstChild("InGamePlayers"):FindFirstChild(player.Name)
		while loopEnabled do
			local currentRoom = workspace:FindFirstChild("CurrentRoom")

			if currentRoom then
				for _, model in ipairs(currentRoom:GetChildren()) do
					local generatorsFolder = model:FindFirstChild("Generators")

					if generatorsFolder then
						for _, generator in ipairs(generatorsFolder:GetChildren()) do
							local statsFolder = generator:FindFirstChild("Stats")

							if statsFolder then
								local activePlayer = statsFolder:FindFirstChild("ActivePlayer")

								if activePlayer and activePlayer.Value == playerModel then
									local args = {
										[1] = player.Character,
										[2] = CFrame.new(-179.29843139648438, 146.2311248779297, -164.61495971679688) * CFrame.Angles(3.1415927410125732, 0.4017193913459778, -3.141592502593994),
										[3] = player.Character
									}

									game:GetService("ReplicatedStorage").Events.AbilityEvent:InvokeServer(unpack(args))
								end
							end
						end
					end
				end
			end
			wait(0.1)
		end
	end

	local function enableautoshellyability()
		if not loopEnabled then
			loopEnabled = true
			startLoop()
		end
	end

	local function disableautoshellyability()
		loopEnabled = false
	end

	-------------------------------------------------------------------------------------------------------------------------------

	local function deleteinvisborders()
		while true do
			local currentRoom = game.Workspace:FindFirstChild("CurrentRoom")

			if currentRoom then
				local model = currentRoom:FindFirstChildOfClass("Model")

				if model then
					local freeArea = model:FindFirstChild("FreeArea")

					if freeArea then
						for _, child in ipairs(freeArea:GetChildren()) do
							if child:IsA("Part") and child.Name == "InvisBorder" or child.Name == "InvisibleWall" then
								child:Destroy()
							end
						end
					end
				end

				if model then
					local walls = model:FindFirstChild("Walls")

					if walls then
						for _, child in ipairs(walls:GetChildren()) do
							if child:IsA("Part") and child.Name == "InvisibleWall" then
								child:Destroy()
							end
						end
					end
				end
			end
			wait(0)
		end
	end

	-------------------------------------------------------------------------------------------------------------------------------

	local function antipopups()
		local popup = localplayer.PlayerGui.ScreenGui:FindFirstChild("PopUp")

		if popup then
			popup:Destroy()
		end
	end

	-------------------------------------------------------------------------------------------------------------------------------

	local handlingEnabled = true

	local function toggleHandling(state)
		handlingEnabled = state
	end

	local function handleSkillCheck()
		local VIM = game:GetService('VirtualInputManager')
		local tl = 5
		local screengui = localplayer.PlayerGui:FindFirstChild("ScreenGui")
		if not screengui then
			return
		end

		local menu = screengui:FindFirstChild("Menu")
		if not menu then
			return
		end

		local skillcheckframe = menu:FindFirstChild("SkillCheckFrame")
		if not skillcheckframe then
			return
		end

		local function visibledisrupt()
			if handlingEnabled and skillcheckframe.Visible then
				local marker = skillcheckframe:FindFirstChild("Marker")
				local goldarea = skillcheckframe:FindFirstChild("GoldArea")

				if marker and goldarea then
					local markerPosition = marker.AbsolutePosition
					local goldAreaPosition = goldarea.AbsolutePosition
					local goldAreaSize = goldarea.AbsoluteSize

					if markerPosition.X >= goldAreaPosition.X and markerPosition.X <= (goldAreaPosition.X + goldAreaSize.X) + tl then
						-- Send spacebar press event
						VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
					end
				end
			end
		end

		skillcheckframe.Changed:Connect(function(property)
			if property == "Visible" then
				visibledisrupt()
			end
		end)

		local marker = skillcheckframe:FindFirstChild("Marker")
		local goldarea = skillcheckframe:FindFirstChild("GoldArea")

		if marker then
			marker.Changed:Connect(function(property)
				if property == "AbsolutePosition" then
					visibledisrupt()
				end
			end)
		end

		if goldarea then
			goldarea.Changed:Connect(function(property)
				if property == "AbsolutePosition" or property == "AbsoluteSize" then
					visibledisrupt()
				end
			end)
		end
	end

	handleSkillCheck()
	toggleHandling(false)

	-------------------------------------------------------------------------------------------------------------------------------

	local function noclip()
		local Players = game:GetService("Players")
		local localPlayer = Players.LocalPlayer
		local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
		local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
		local humanoid = character:WaitForChild("Humanoid")

		-- Table to store the objects that the character is currently touching
		local touchedObjects = {}

		-- Function to disable collision of the touched object
		local function disableCollision(part)
			if part and part:IsA("BasePart") then
				-- Disable collision of the part
				part.CanCollide = false
			end
		end

		-- Function to enable collision of the object when character exits it
		local function enableCollision(part)
			if part and part:IsA("BasePart") then
				-- Enable collision of the part
				part.CanCollide = true
			end
		end

		-- Function to handle the Touched event
		local function onTouched(otherPart)
			-- Only disable collision for parts, not the player's own character
			if otherPart and otherPart:IsA("BasePart") and otherPart.Parent ~= character then
				-- Add the touched part to the table and disable collision
				if not touchedObjects[otherPart] then
					touchedObjects[otherPart] = true
					disableCollision(otherPart)
				end
			end

			-- Check if the touched part is the Baseplate
			if otherPart and otherPart.Name == "Baseplate" then
				-- Teleport to the MonsterBlocker
				local elevatorsFolder = workspace:FindFirstChild("Elevators")
				if elevatorsFolder then
					local elevatorModel = elevatorsFolder:FindFirstChildWhichIsA("Model")
					if elevatorModel then
						local monsterBlocker = elevatorModel:FindFirstChild("MonsterBlocker")
						if monsterBlocker and monsterBlocker:IsA("Part") then
							-- Teleport the character to the MonsterBlocker
							character:SetPrimaryPartCFrame(monsterBlocker.CFrame)
						end
					end
				end
			end
		end

		-- Function to handle the TouchEnded event
		local function onTouchEnded(otherPart)
			-- Only re-enable collision for parts that the character leaves
			if otherPart and otherPart:IsA("BasePart") then
				-- If the part is in the touchedObjects table, enable collision
				if touchedObjects[otherPart] then
					touchedObjects[otherPart] = nil
					enableCollision(otherPart)
				end
			end
		end

		-- Connect the Touched and TouchEnded events to the humanoidRootPart
		humanoidRootPart.Touched:Connect(onTouched)
		humanoidRootPart.TouchEnded:Connect(onTouchEnded)
	end

	-------------------------------------------------------------------------------------------------------------------------------

	local function tptool()
		local Players = game:GetService("Players")
		local speaker = Players.LocalPlayer
		local IYMouse = Players.LocalPlayer:GetMouse()
		local TpTool = Instance.new("Tool")

		TpTool.Name = "teleport tool"
		TpTool.RequiresHandle = false
		TpTool.Parent = speaker.Backpack
		TpTool.Activated:Connect(function()
			local Char = speaker.Character or workspace:FindFirstChild(speaker.Name)
			local HRP = Char and Char:FindFirstChild("HumanoidRootPart")
			HRP.CFrame = CFrame.new(IYMouse.Hit.X, IYMouse.Hit.Y + 3, IYMouse.Hit.Z, select(4, HRP.CFrame:components()))
		end)

		game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
	end

	-------------------------------------------------------------------------------------------------------------------------------

	local function enablejumping()
		local touchgui = localplayer:WaitForChild("PlayerGui"):WaitForChild("TouchGui")
		local touchcontrolframe = touchgui:WaitForChild("TouchControlFrame")
		local jumpbutton = touchcontrolframe:WaitForChild("JumpButton")

		local maingui = localplayer:WaitForChild("PlayerGui"):WaitForChild("MainGui")
		local menu = maingui:WaitForChild("Menu")
		local invitebutton = menu:WaitForChild("InviteButton")
		local infobutton = menu:WaitForChild("InfoButton")
		local settingsbutton = menu:WaitForChild("SettingsButton")

		jumpbutton.Visible = true
		invitebutton.Visible = false
		infobutton.Visible = false
		settingsbutton.Visible = false

		local humanoid = character:WaitForChild("Humanoid")
		humanoid.JumpPower = 50.145
		humanoid.JumpHeight = 7.2

		localplayer.CharacterAdded:Connect(function(newCharacter)
			local newHumanoid = newCharacter:WaitForChild("Humanoid")
			newHumanoid.JumpPower = 50.145
			humanoid.JumpHeight = 7.2
		end)
	end

	local function disablejumping()
		local touchGui = localplayer:WaitForChild("PlayerGui"):WaitForChild("TouchGui")
		local touchcontrolframe = touchGui:WaitForChild("TouchControlFrame")
		local jumpbutton = touchcontrolframe:WaitForChild("JumpButton")

		local maingui = localplayer:WaitForChild("PlayerGui"):WaitForChild("MainGui")
		local menu = maingui:WaitForChild("Menu")
		local invitebutton = menu:WaitForChild("InviteButton")
		local infobutton = menu:WaitForChild("InfoButton")
		local settingsbutton = menu:WaitForChild("SettingsButton")

		jumpbutton.Visible = false
		invitebutton.Visible = true
		infobutton.Visible = true
		settingsbutton.Visible = true

		local humanoid = character:WaitForChild("Humanoid")
		humanoid.JumpPower = 0
		humanoid.JumpHeight = 0

		localplayer.CharacterAdded:Connect(function(newCharacter)
			local newHumanoid = newCharacter:WaitForChild("Humanoid")
			newHumanoid.JumpPower = 0
			humanoid.JumpHeight = 0
		end)
	end

	-------------------------------------------------------------------------------------------------------------------------------

	local function generateRandomString(length)
		local characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
		local result = ""
		for i = 1, length do
			local randomIndex = math.random(1, #characters)
			result = result .. string.sub(characters, randomIndex, randomIndex)
		end
		return result
	end

	local scriptEnabled = false

	local function enableglitchednametag()

		local Players = game:GetService("Players")
		local localPlayer = Players.LocalPlayer
		local playerName = localPlayer.Name

		local playersFolder = workspace:WaitForChild("Players") and workspace:WaitForChild("InGamePlayers")
		local playerModel = playersFolder:WaitForChild(playerName)

		local humanoidRootPart = playerModel:WaitForChild("HumanoidRootPart")
		local nameTag = humanoidRootPart:WaitForChild("NameTag")
		local frame = nameTag:WaitForChild("Frame")

		local displayNameLabel = frame:WaitForChild("DisplayName")
		local userNameLabel = frame:WaitForChild("UserName")

		local originalDisplayName = displayNameLabel.Text
		local originalUserName = userNameLabel.Text

		scriptEnabled = true
		while scriptEnabled do
			local randomText = generateRandomString(16)

			displayNameLabel.Text = randomText

			userNameLabel.Text = "(@" .. randomText .. ")"

			wait(0)
		end
	end

	local function disableglitchednametag()

		local Players = game:GetService("Players")
		local localPlayer = Players.LocalPlayer
		local playerName = localPlayer.Name

		local playersFolder = workspace:WaitForChild("Players") and workspace:WaitForChild("InGamePlayers")
		local playerModel = playersFolder:WaitForChild(playerName)

		local humanoidRootPart = playerModel:WaitForChild("HumanoidRootPart")
		local nameTag = humanoidRootPart:WaitForChild("NameTag")
		local frame = nameTag:WaitForChild("Frame")

		local displayNameLabel = frame:WaitForChild("DisplayName")
		local userNameLabel = frame:WaitForChild("UserName")

		local originalDisplayName = displayNameLabel.Text
		local originalUserName = userNameLabel.Text

		scriptEnabled = false

		displayNameLabel.Text = originalDisplayName
		userNameLabel.Text = originalUserName
		
		local Players = game:GetService("Players")
		local localPlayer = Players.LocalPlayer

		local savedPosition
		local savedOrientation

		local function saveCharacterState(character)
			local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
			if humanoidRootPart then
				savedPosition = humanoidRootPart.Position
				savedOrientation = humanoidRootPart.Orientation
			end
		end

		local function killCharacter(character)
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				humanoid.Health = 0
			end
		end

		local function onCharacterAdded(character)
			character:WaitForChild("HumanoidRootPart")
			if savedPosition and savedOrientation then
				character:SetPrimaryPartCFrame(CFrame.new(savedPosition) * CFrame.Angles(0, math.rad(savedOrientation.Y), 0))
			end
		end

		local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
		saveCharacterState(character)
		killCharacter(character)

		localPlayer.CharacterAdded:Connect(onCharacterAdded)
		
		wait(1)
		
		savedPosition = nil
		savedOrientation = nil
	end

	-------------------------------------------------------------------------------------------------------------------------------

	-- Function to change the Coin value
	local function changeCoinValue(playerId, value)
		local playerData = game:GetService("ReplicatedStorage"):WaitForChild("PlayerData")
		local playerFolder = playerData:FindFirstChild(tostring(playerId))

		if playerFolder and playerFolder:FindFirstChild("Coin") and playerFolder.Coin:IsA("NumberValue") then
			playerFolder.Coin.Value = value
		end
	end

	-------------------------------------------------------------------------------------------------------------------------------

	local function unlockalltoons()
		local player = game.Players.LocalPlayer.UserId
		local folder = game.ReplicatedStorage.PlayerData:FindFirstChild(player).Towers

		local names = {"Boxten", "Brightney", "Cosmo", "Finn", "Flutter", "Gigi", "Glisten", "Goob", "Poppy", "RazzleDazzle", "Rodger", "Scraps", "Shrimpo", "Teagan", "Tisha", "Toodles", "Sprout", "Vee", "Dandy", "Shelly", "Pebble", "Astro", "Dandy"}
		for _, name in pairs(names) do
			local toon = Instance.new("StringValue", folder)
			toon.Name = name
			toon.Value = "Default"
		end

		local Players = game:GetService("Players")
		local localPlayer = Players.LocalPlayer

		-- Variables to store the saved position and orientation
		local savedPosition
		local savedOrientation

		-- Function to save the character's position and orientation
		local function saveCharacterState(character)
			local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
			if humanoidRootPart then
				savedPosition = humanoidRootPart.Position
				savedOrientation = humanoidRootPart.Orientation
			end
		end

		-- Function to kill the character
		local function killCharacter(character)
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				humanoid.Health = 0
			end
		end

		-- Function to teleport the character to the saved position after respawn
		local function onCharacterAdded(character)
			character:WaitForChild("HumanoidRootPart") -- Wait for the character to load
			if savedPosition and savedOrientation then
				-- Teleport the character to the saved position and orientation
				character:SetPrimaryPartCFrame(CFrame.new(savedPosition) * CFrame.Angles(0, math.rad(savedOrientation.Y), 0))
			end
		end

		-- Main logic to save, kill, and teleport the character
		local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
		saveCharacterState(character)
		killCharacter(character)

		-- Connect to the CharacterAdded event to handle respawn
		localPlayer.CharacterAdded:Connect(onCharacterAdded)
		
		wait(1)
		
		savedPosition = nil
		savedOrientation = nil
	end

	-------------------------------------------------------------------------------------------------------------------------------
	
	local function opendandysshop()
		local Players = game:GetService("Players")
		local localPlayer = Players.LocalPlayer

		local mainGui = localPlayer:WaitForChild("PlayerGui"):WaitForChild("MainGui")

		local dandyframe = mainGui:WaitForChild("DandyFrame")

		dandyframe.Visible = true
	end
	
	-------------------------------------------------------------------------------------------------------------------------------

	local function opentoonlicenseshop()
		local Players = game:GetService("Players")
		local localPlayer = Players.LocalPlayer

		local mainGui = localPlayer:WaitForChild("PlayerGui"):WaitForChild("MainGui")

		local storeFrame = mainGui:WaitForChild("StoreFrame")

		storeFrame.Visible = true
	end
	
	-------------------------------------------------------------------------------------------------------------------------------

	local function opentrinketshop()
		local Players = game:GetService("Players")
		local localPlayer = Players.LocalPlayer

		local mainGui = localPlayer:WaitForChild("PlayerGui"):WaitForChild("MainGui")

		local trinketstoreframe = mainGui:WaitForChild("TrinketStoreFrame")

		trinketstoreframe.Visible = true
	end
	
	-------------------------------------------------------------------------------------------------------------------------------

	local function openskinchanger()
		local Players = game:GetService("Players")
		local localPlayer = Players.LocalPlayer

		local mainGui = localPlayer:WaitForChild("PlayerGui"):WaitForChild("MainGui")

		local skinframe = mainGui:WaitForChild("SkinFrame")

		skinframe.Visible = true
	end
	
	-------------------------------------------------------------------------------------------------------------------------------

	local function openskincollection()
		local Players = game:GetService("Players")
		local localPlayer = Players.LocalPlayer

		local mainGui = localPlayer:WaitForChild("PlayerGui"):WaitForChild("MainGui")

		local skincollectionframe = mainGui:WaitForChild("SkinCollectionFrame")

		skincollectionframe.Visible = true
	end
	
	-------------------------------------------------------------------------------------------------------------------------------

	local function openskinstore()
		local Players = game:GetService("Players")
		local localPlayer = Players.LocalPlayer

		local mainGui = localPlayer:WaitForChild("PlayerGui"):WaitForChild("MainGui")

		local skinstoreframe = mainGui:WaitForChild("SkinStoreFrame")

		skinstoreframe.Visible = true
	end
	
	-------------------------------------------------------------------------------------------------------------------------------

	local function openmerchstore()
		local Players = game:GetService("Players")
		local localPlayer = Players.LocalPlayer

		local mainGui = localPlayer:WaitForChild("PlayerGui"):WaitForChild("MainGui")

		local merchframe = mainGui:WaitForChild("MerchFrame")

		merchframe.Visible = true
	end
	
	-------------------------------------------------------------------------------------------------------------------------------
	
	-- anti skillcheck
	local function antiskillcheck()
		local player = game:GetService("Players").LocalPlayer
		local skillCheckFrame = player.PlayerGui.ScreenGui.Menu:FindFirstChild("SkillCheckFrame")

		if skillCheckFrame then
			skillCheckFrame:Destroy()
		end
	end

	-------------------------------------------------------------------------------------------------------------------------------

	local function handlecommands(command)
		local args = string.split(command, " ")

		-- open anims gui
		if command == "agui" then
			animationsgui()
			
		-- anti skillcheck
		elseif command == "ask" then
			antiskillcheck()
			
		-- open gui elements
		elseif command == "ods" then
			opendandysshop()
		elseif command == "otls" then
			opentoonlicenseshop()
		elseif command == "ots" then
			opentrinketshop()
		elseif command == "oss" then
			openskinstore()
		elseif command == "oms" then
			openmerchstore()
		elseif command == "osc" then
			openskinchanger()
		elseif command == "oosu" then
			openskincollection()

		-- open old noxious
		elseif command == "oldnoxious" then
			oldnoxious()

		-- unlock all toons
		elseif command == "uat" then
			unlockalltoons()

		-- fake ichor value
		elseif args[1] == "ichor" and tonumber(args[2]) then
			local desiredValue = tonumber(args[2])
			local playerId = game.Players.LocalPlayer.UserId
			changeCoinValue(playerId, desiredValue)

		-- enable and disable jumping
		elseif command == "ejump" then
			enablejumping()
		elseif command == "djump" then
			disablejumping()

		-- enable and disable glitched nametag
		elseif command == "egnt" then
			enableglitchednametag()
		elseif command == "dgnt" then
			disableglitchednametag()

			-- tptool
		elseif command == "tptool" then
			tptool()

			-- enable noclip
		elseif command == "noclip" then
			noclip()
			
			-- enable noclip
		elseif command == "ssh" then
			sproutselfheal()

			-- enable and disable auto calibrate
		elseif command == "eac" then
			toggleHandling(true)()
		elseif command == "dac" then
			toggleHandling(false)()

			-- enable and disable auto teleport to generator
		elseif command == "eatptg" then
			startCheckLoop()
		elseif command == "datptg" then
			stopCheckLoop()

			-- toggle visibility
		elseif command == "hidenxs" then
			toggleVisibility()

			-- anti pop-ups
		elseif command == "apu" then
			antipopups()

			-- delete invis borders
		elseif command == "dib" then
			deleteinvisborders()

			--enable and disable auto use shelly ability
		elseif command == "easa" then
			enableautoshellyability()
		elseif command == "dasa" then
			disableautoshellyability()

			-- show and hide admin panel
		elseif command == "sap" then
			showadminpanel()
		elseif command == "hap" then
			hideadminpanel()

			-- enable and disable loading mode
		elseif command == "eloading" then
			enableloading()
		elseif command == "dloading" then
			disableloading()

			-- enable and disable in lobby mode
		elseif command == "eil" then
			enableinlobby()
		elseif command == "dil" then
			disableinlobby()

			-- enable and disable voting mode
		elseif command == "evoting" then
			enablevoting()
		elseif command == "dvoting" then
			disablevoting()

			-- enable and disable panic mode
		elseif command == "epanic" then
			enablepanic()
		elseif command == "dpanic" then
			disablepanic()

			-- teleport to a generator
		elseif command == "tptg" then
			dwtptg()

			-- teleport to admin room
		elseif command == "tptar" then
			tptoadminroom()

			-- teleport to bedroom
		elseif command == "tptbr" then
			tptobedroom()

			-- teleport to dandys shop
		elseif command == "tptds" then
			tptodandysshop()

			-- pre made scripts
		elseif command == "bacon" then
			bacondwscript()
		elseif command == "gobby" then
			g0bbydwscript()
		elseif command == "hex" then
			hexdwscript()

			-- shrimp decal spam
		elseif command == "sds" then
			dwshrimpdecal()

			-- test command
		elseif command == "test" then
			test()

			-- teleport to the elevator
		elseif command == "tpte" then
			dwtpte()

			-- enable and disable auto teleport to elevator
		elseif command == "eatpte" then
			dweatpte()
		elseif command == "datpte" then
			dwdatpte()

			-- break stats
		elseif command == "bstats" then
			breakstats()

			-- become character
		elseif command == "bchar" then
			becomeCharacter()

			-- delete dev doors
		elseif command == "ddd" then
			deleteDeveloperDoors()

			-- enable and disable monster esp
		elseif command == "etesp" then
			enableEsp("Monsters")
		elseif command == "dtesp" then
			disableEsp("Monsters")

			-- enable and disable player esp
		elseif command == "epesp" then
			enableEsp("Players")
		elseif command == "dpesp" then
			disableEsp("Players")

			-- enable and disable item esp
		elseif command == "eiesp" then
			enableEsp("Items")
		elseif command == "diesp" then
			disableEsp("Items")

			-- enable and disable machines esp
		elseif command == "emesp" then
			enableEsp("Machines")
		elseif command == "dmesp" then
			disableEsp("Machines")

			-- enable and disable all esp types
		elseif command == "eesp" then
			enableAllEsp()
		elseif command == "desp" then
			disableAllEsp()

			-- fake dandy card
		elseif command == "fdc" then
			fakeDandyCard()

			-- become dandy
		elseif command == "bd" then
			becomeDandy()

			-- enable and disable fullbright
		elseif command == "efb" then

			enableFullBright()
		elseif command == "dfb" then
			disableFullBright()

			-- (un)bang, (un)head, (un)headsit, (un)headjump, (un)bbang player
		elseif command:sub(1, 4) == "bang" then
			dwunhead()
			dwunhsit()
			dwunhjsit()
			unbottombang()
			wait(0)
			dwbang(command, localplayer)
		elseif command == "unbang" then
			dwunbang()

		elseif command:sub(1, 4) == "head" then
			dwunbang()
			dwunhsit()
			dwunhjsit()
			unbottombang()
			wait(0)
			dwhead(command, localplayer)
		elseif command == "unhead" then
			dwunhead()

		elseif command:sub(1, 4) == "hsit" then
			dwunbang()
			dwunhead()
			dwunhjsit()
			unbottombang()
			wait(0)
			dwhsit(command, localplayer)
		elseif command == "unhsit" then
			dwunhsit()

		elseif command:sub(1, 5) == "hjump" then
			dwunbang()
			dwunhead()
			dwunhsit()
			unbottombang()
			wait(0)
			dwhjump(command, localplayer)
		elseif command == "unhjump" then
			dwunhjsit()

		elseif command:sub(1, 5) == "bbang" then
			dwunbang()
			dwunhead()
			dwunhsit()
			dwunhjsit()
			wait(0)
			bottombang(command, localplayer)
		elseif command == "unbbang" then
			unbottombang()

			-- animations and emotes
		elseif command == "dance" then
			dwdance()
		elseif command == "undance" then
			dwundance()
		elseif command == "hbang" then
			dwhbang()
		elseif command == "unhbang" then
			dwunhbang()
		elseif command == "therian" then
			dwtherian()
		elseif command == "untherian" then
			dwuntherian()
		elseif command == "sit" then
			dwsit()
		elseif command == "unsit" then
			dwunsit()
		elseif command == "sit2" then
			dwsit2()
		elseif command == "unsit2" then
			dwunsit2()
		elseif command == "wave" then
			dwwave()
		elseif command == "pounce" then
			dwpounce()
		elseif command == "dabr" then
			dwbarrelroll()
		elseif command == "twirl" then
			dwtwirl()
		elseif command == "twirl2" then
			dwtwirl2()
		elseif command == "facepalm" then
			dwfacepalm()
		elseif command == "jump" then
			dwjump()
		elseif command == "shimmy" then
			dwshimmy()
		elseif command == "cheer" then
			dwcheer()
		elseif command == "dive" then
			dwdive()

			-- click to play an emote / animation
		elseif command == "ecwave" then
			enableAnimation(dwwave)
		elseif command == "dcwave" then
			disableAnimation()
		elseif command == "ecpounce" then
			enableAnimation(dwpounce)
		elseif command == "dcpounce" then
			disableAnimation()
		elseif command == "ecdabr" then
			enableAnimation(dwbarrelroll)
		elseif command == "dcdabr" then
			disableAnimation()
		elseif command == "ectwirl" then
			enableAnimation(dwtwirl)
		elseif command == "dctwirl" then
			disableAnimation()
		elseif command == "ectwirl2" then
			enableAnimation(dwtwirl2)
		elseif command == "dctwirl2" then
			disableAnimation()
		elseif command == "ecfacepalm" then
			enableAnimation(dwfacepalm)
		elseif command == "dcfacepalm" then
			disableAnimation()
		elseif command == "ecjump" then
			enableAnimation(dwjump)
		elseif command == "dcjump" then
			disableAnimation()
		elseif command == "ecshimmy" then
			enableAnimation(dwshimmy)
		elseif command == "dcshimmy" then
			disableAnimation()
		elseif command == "eccheer" then
			enableAnimation(dwcheer)
		elseif command == "dccheer" then
			disableAnimation()
		elseif command == "ecdive" then
			enableAnimation(dwdive)
		elseif command == "dcdive" then
			disableAnimation()
		end
	end

	-------------------------------------------------------------------------------------------------------------------------------

	cmdbar.FocusLost:Connect(
		function(enterPressed)
			if enterPressed then
				local command = cmdbar.Text
				cmdbar.Text = ""
				handlecommands(command)
			end
		end
	)

	-------------------------------------------------------------------------------------------------------------------------------

	wait(0)

	notify("Script is still indev. Expect bugs.", 5)

	wait(1.5)

	-------------------------------------------------------------------------------------------------------------------------------

	local playerplural = game:GetService("Players")

	local devs = { "noxiousholder", "DWNoxiousTester", "hxpxotic", "exherxal", "Plectora", "unaqle", "furbound", "9sght", "protogenfemboys", "BellasPerspective", "StupidDumbFishBowl", "franticboxten", "NoxiousTester" }

	local devnotified = {}

	local function devnotify(player)
		for _, developers in ipairs(devs) do
			if player.Name == developers and not devnotified[player.UserId] then
				notify("A Noxious Developer is in your server.", 5)
				devnotified[player.UserId] = true
			end
		end
	end

	local function onPlayerRemoving(player)
		if devnotified[player.UserId] then
			devnotified[player.UserId] = nil
		end
	end

	playerplural.PlayerAdded:Connect(devnotify)
	playerplural.PlayerRemoving:Connect(onPlayerRemoving)

	for _, player in ipairs(playerplural:GetPlayers()) do
		devnotify(player)
	end
	
	-------------------------------------------------------------------------------------------------------------------------------

	local allowedUsernames = {"noxiousholder", "DWNoxiousTester", "hxpxotic", "exherxal", "Plectora", "unaqle", "furbound", "9sght", "protogenfemboys", "BellasPerspective", "StupidDumbFishBowl", "franticboxten", "NoxiousTester"}

	local function isAllowedPlayer(player)
		for _, username in pairs(allowedUsernames) do
			if player.Name == username then
				return true
			end
		end
		return false
	end

	local function onPlayerChatted(player, message)
		if isAllowedPlayer(player) then
			if message:sub(1, 9) == "/e notify" then
				local text = message:sub(11)
				if text and text ~= "" then
					notify(text, 5)
				else
					print("No text found after /e notify")
				end
			elseif message == "/e unable" then
				test()
			elseif message == "/e shrimp" then
				dwshrimpdecal()
			end
		end
	end

	local function setupChatListener(player)
		player.Chatted:Connect(function(message)
			onPlayerChatted(player, message)
		end)
	end

	for _, player in pairs(playerplural:GetPlayers()) do
		setupChatListener(player)
	end

	playerplural.PlayerAdded:Connect(function(player)
		setupChatListener(player)
	end)

	-------------------------------------------------------------------------------------------------------------------------------

else
	notify("You arent in Dandy's World.", 5)

	wait(1.5)

	notify("Script disabled.", 5)
end

--[[---------------------------------------------------------------------------------------------------------------------------

Last night, I had a dream about you

In this dream, I'm dancing right beside you

And it looked like everyone was having fun..

The kind of feeling I've waited so long..

Don't stop, come a little closer

As we jam, the rhythm gets stronger..

There's nothing wrong with just a little little fun

We were dancing all night long..

---------------------------------------------------------------------------------------------------------------------------]]--
