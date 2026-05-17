local Start = tick()

-- 显示欢迎消息
game:GetService("StarterGui"):SetCore("SendNotification",{
    Title = "cl hub 2026",
    Text = "正在加载完整脚本...",
    Duration = 2
})

-- 全局变量
local InfiniteJump = false
local Noclip = false
local FlyEnabled = false
local FlyBodyVelocity = nil
local MainUI = nil
local MiniUI = nil
local LanguageMenu = nil
local isMinimized = false

-- 创建缩小界面
local function CreateMiniUI()
    local Player = game:GetService("Players").LocalPlayer
    local PlayerGui = Player:WaitForChild("PlayerGui")
    
    if MiniUI then
        MiniUI:Destroy()
    end
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "CLHubMiniUI"
    ScreenGui.Parent = PlayerGui
    ScreenGui.ResetOnSpawn = false
    
    local MiniFrame = Instance.new("Frame")
    MiniFrame.Parent = ScreenGui
    MiniFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    MiniFrame.Position = UDim2.new(0.02, 0, 0.02, 0)
    MiniFrame.Size = UDim2.new(0, 120, 0, 70)
    MiniFrame.Active = true
    MiniFrame.Draggable = true
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = MiniFrame
    
    local Title = Instance.new("TextLabel")
    Title.Parent = MiniFrame
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 5, 0, 5)
    Title.Size = UDim2.new(1, -10, 0, 18)
    Title.Font = Enum.Font.SourceSansBold
    Title.Text = "cl hub 2026"
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.TextSize = 14
    
    local Author = Instance.new("TextLabel")
    Author.Parent = MiniFrame
    Author.BackgroundTransparency = 1
    Author.Position = UDim2.new(0, 5, 0, 23)
    Author.Size = UDim2.new(1, -10, 0, 15)
    Author.Font = Enum.Font.SourceSans
    Author.Text = "快手:3875377803"
    Author.TextColor3 = Color3.fromRGB(255, 200, 100)
    Author.TextSize = 10
    
    local RestoreBtn = Instance.new("TextButton")
    RestoreBtn.Parent = MiniFrame
    RestoreBtn.BackgroundColor3 = Color3.fromRGB(80, 180, 255)
    RestoreBtn.Position = UDim2.new(0, 5, 0, 48)
    RestoreBtn.Size = UDim2.new(1, -10, 0, 17)
    RestoreBtn.Font = Enum.Font.SourceSansBold
    RestoreBtn.Text = "🔼 点击恢复"
    RestoreBtn.TextColor3 = Color3.new(1, 1, 1)
    RestoreBtn.TextSize = 11
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 4)
    BtnCorner.Parent = RestoreBtn
    
    RestoreBtn.MouseEnter:Connect(function()
        RestoreBtn.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
    end)
    
    RestoreBtn.MouseLeave:Connect(function()
        RestoreBtn.BackgroundColor3 = Color3.fromRGB(80, 180, 255)
    end)
    
    RestoreBtn.MouseButton1Click:Connect(function()
        if MainUI then
            MainUI.Enabled = true
        end
        ScreenGui.Enabled = false
        isMinimized = false
        
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "cl hub",
            Text = "窗口已恢复",
            Duration = 2
        })
    end)
    
    ScreenGui.Enabled = false
    MiniUI = ScreenGui
    return ScreenGui
end

-- 创建主界面
local function CreateMainUI()
    local Player = game:GetService("Players").LocalPlayer
    local PlayerGui = Player:WaitForChild("PlayerGui")
    
    -- 清理旧UI
    for _, gui in pairs(PlayerGui:GetChildren()) do
        if gui.Name == "CLHubUI" or gui.Name == "LanguageMenuUI" then
            gui:Destroy()
        end
    end
    
    -- 创建主UI
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "CLHubUI"
    ScreenGui.Parent = PlayerGui
    ScreenGui.ResetOnSpawn = false
    
    -- 主窗口
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainWindow"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    MainFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
    MainFrame.Size = UDim2.new(0, 400, 0, 450)
    MainFrame.Active = true
    MainFrame.Draggable = true
    
    -- 圆角
    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 10)
    MainCorner.Parent = MainFrame
    
    -- 标题栏
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Parent = MainFrame
    TitleBar.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    
    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 10)
    TitleCorner.Parent = TitleBar
    
    -- 标题文字
    local TitleText = Instance.new("TextLabel")
    TitleText.Parent = TitleBar
    TitleText.BackgroundTransparency = 1
    TitleText.Size = UDim2.new(0.65, 0, 1, 0)
    TitleText.Position = UDim2.new(0, 10, 0, 0)
    TitleText.Font = Enum.Font.SourceSansBold
    TitleText.Text = "cl hub 2026"
    TitleText.TextColor3 = Color3.new(1, 1, 1)
    TitleText.TextSize = 18
    TitleText.TextXAlignment = Enum.TextXAlignment.Left
    
    -- 快手号显示
    local KuaishouText = Instance.new("TextLabel")
    KuaishouText.Parent = TitleBar
    KuaishouText.BackgroundTransparency = 1
    KuaishouText.Size = UDim2.new(0.35, -40, 1, 0)
    KuaishouText.Position = UDim2.new(0.65, 0, 0, 0)
    KuaishouText.Font = Enum.Font.SourceSans
    KuaishouText.Text = "快手:3875377803"
    KuaishouText.TextColor3 = Color3.fromRGB(255, 220, 120)
    KuaishouText.TextSize = 12
    KuaishouText.TextXAlignment = Enum.TextXAlignment.Left
    
    -- 按钮容器
    local ButtonContainer = Instance.new("Frame")
    ButtonContainer.Parent = TitleBar
    ButtonContainer.BackgroundTransparency = 1
    ButtonContainer.Position = UDim2.new(0.85, 0, 0, 0)
    ButtonContainer.Size = UDim2.new(0.15, 0, 1, 0)
    
    -- 语言按钮
    local LanguageBtn = Instance.new("TextButton")
    LanguageBtn.Name = "LanguageBtn"
    LanguageBtn.Parent = TitleBar
    LanguageBtn.BackgroundColor3 = Color3.fromRGB(150, 100, 200)
    LanguageBtn.Position = UDim2.new(0.7, 5, 0.5, -10)
    LanguageBtn.Size = UDim2.new(0, 40, 0, 20)
    LanguageBtn.Text = "🌐"
    LanguageBtn.TextColor3 = Color3.new(1, 1, 1)
    
    local LangCorner = Instance.new("UICorner")
    LangCorner.CornerRadius = UDim.new(0, 4)
    LangCorner.Parent = LanguageBtn
    
    -- 缩小按钮
    local MinimizeBtn = Instance.new("TextButton")
    MinimizeBtn.Name = "MinimizeBtn"
    MinimizeBtn.Parent = ButtonContainer
    MinimizeBtn.BackgroundColor3 = Color3.fromRGB(100, 150, 200)
    MinimizeBtn.Position = UDim2.new(0, 5, 0.5, -12)
    MinimizeBtn.Size = UDim2.new(0, 24, 0, 24)
    MinimizeBtn.Font = Enum.Font.SourceSansBold
    MinimizeBtn.Text = "–"
    MinimizeBtn.TextColor3 = Color3.new(1, 1, 1)
    MinimizeBtn.TextSize = 16
    
    -- 关闭按钮
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Name = "CloseBtn"
    CloseBtn.Parent = ButtonContainer
    CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 80, 80)
    CloseBtn.Position = UDim2.new(0.5, 5, 0.5, -12)
    CloseBtn.Size = UDim2.new(0, 24, 0, 24)
    CloseBtn.Font = Enum.Font.SourceSansBold
    CloseBtn.Text = "×"
    CloseBtn.TextColor3 = Color3.new(1, 1, 1)
    CloseBtn.TextSize = 18
    
    -- 按钮圆角
    local MinCorner = Instance.new("UICorner")
    MinCorner.CornerRadius = UDim.new(0, 5)
    MinCorner.Parent = MinimizeBtn
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 5)
    CloseCorner.Parent = CloseBtn
    
    -- 按钮悬停效果
    LanguageBtn.MouseEnter:Connect(function()
        LanguageBtn.BackgroundColor3 = Color3.fromRGB(170, 120, 220)
    end)
    
    LanguageBtn.MouseLeave:Connect(function()
        LanguageBtn.BackgroundColor3 = Color3.fromRGB(150, 100, 200)
    end)
    
    MinimizeBtn.MouseEnter:Connect(function()
        MinimizeBtn.BackgroundColor3 = Color3.fromRGB(120, 170, 220)
    end)
    
    MinimizeBtn.MouseLeave:Connect(function()
        MinimizeBtn.BackgroundColor3 = Color3.fromRGB(100, 150, 200)
    end)
    
    CloseBtn.MouseEnter:Connect(function()
        CloseBtn.BackgroundColor3 = Color3.fromRGB(240, 100, 100)
    end)
    
    CloseBtn.MouseLeave:Connect(function()
        CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 80, 80)
    end)
    
    -- 内容区域
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Parent = MainFrame
    ContentFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    ContentFrame.Position = UDim2.new(0, 0, 0, 40)
    ContentFrame.Size = UDim2.new(1, 0, 1, -40)
    
    local ContentCorner = Instance.new("UICorner")
    ContentCorner.CornerRadius = UDim.new(0, 10)
    ContentCorner.Parent = ContentFrame
    
    -- 滚动框
    local ScrollFrame = Instance.new("ScrollingFrame")
    ScrollFrame.Parent = ContentFrame
    ScrollFrame.Size = UDim2.new(1, 0, 1, 0)
    ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0,3000)
    ScrollFrame.ScrollBarThickness = 8
    ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 120)
    ScrollFrame.BackgroundTransparency = 1
    
    -- 按钮创建函数
    local function CreateButton(text, yPos, callback)
        local Button = Instance.new("TextButton")
        Button.Parent = ScrollFrame
        Button.Size = UDim2.new(0.9, 0, 0, 45)
        Button.Position = UDim2.new(0.05, 0, 0, yPos)
        Button.BackgroundColor3 = Color3.fromRGB(60, 60, 90)
        Button.Text = text
        Button.TextColor3 = Color3.new(1, 1, 1)
        Button.TextSize = 15
        Button.Font = Enum.Font.SourceSansBold
        
        local BtnCorner = Instance.new("UICorner")
        BtnCorner.CornerRadius = UDim.new(0, 8)
        BtnCorner.Parent = Button
        
        Button.MouseEnter:Connect(function()
            Button.BackgroundColor3 = Color3.fromRGB(70, 70, 110)
            Button.TextColor3 = Color3.new(1, 1, 1)
        end)
        
        Button.MouseLeave:Connect(function()
            Button.BackgroundColor3 = Color3.fromRGB(60, 60, 90)
            Button.TextColor3 = Color3.new(1, 1, 1)
        end)
        
        Button.MouseButton1Click:Connect(callback)
        
        return Button
    end
    
    --添加功能按钮
    local yOffset = 20
    
    -- 1. 无限跳
    CreateButton("🏃‍♂️ 无限跳跃", yOffset, function()
        InfiniteJump = not InfiniteJump
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "cl hub",
            Text = InfiniteJump and "无限跳已开启" or "无限跳已关闭",
            Icon = "rbxassetid://105677776902677",
            Duration = 2
        })
    end)
    yOffset = yOffset + 55
    
    -- 2. 夜视模式
    CreateButton("🌙 夜视模式", yOffset, function()
        if game.Lighting.Brightness < 2 then
            game.Lighting.Brightness = 2
            game.Lighting.Ambient = Color3.new(1, 1, 1)
            game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "cl hub",
                Text = "夜视模式已开启",
                Duration = 2
            })
        else
            game.Lighting.Brightness = 1
            game.Lighting.Ambient = Color3.new(0, 0, 0)
            game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "cl hub",
                Text = "夜视模式已关闭",
                Duration = 2
            })
        end
    end)
    yOffset = yOffset + 55
    
    -- 3. 穿墙模式
    CreateButton("🚪 穿墙模式", yOffset, function()
        Noclip = not Noclip
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "cl hub",
            Text = Noclip and "穿墙模式已开启" or "穿墙模式已关闭",
            Duration = 2
        })
    end)
    yOffset = yOffset + 55
    
    -- 4. 飞行模式
    CreateButton("✈️ 飞行模式", yOffset, function()
        FlyEnabled = not FlyEnabled
 
        if FlyEnabled then
            local character = game.Players.LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                FlyBodyVelocity = Instance.new("BodyVelocity")
                FlyBodyVelocity.Parent = character.HumanoidRootPart
                FlyBodyVelocity.MaxForce = Vector3.new(10000, 10000, 10000)
                FlyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
            end
            game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "cl hub",
                Text = "飞行模式已开启 (WASD控制)",
                Duration = 2
            })
        else
            if FlyBodyVelocity then
                FlyBodyVelocity:Destroy()
                FlyBodyVelocity = nil
            end
            game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "cl hub",
                Text = "飞行模式已关闭",
                Duration = 2
            })
        end
    end)
    yOffset = yOffset + 55
    
    -- 5. 逃离海啸获得脑红
    CreateButton("🌊 逃离海啸获得脑红", yOffset, function()
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "cl hub",
            Text = "正在加载逃离海啸脚本...",
            Duration = 2
        })
        
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/yuhub1/hanhua/refs/heads/main/wavehanhua.txt"))()
        end)
        
        if success then
            game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "cl hub",
                Text = "✅ 加载成功",
                Duration = 2
            })
        else
            game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "cl hub",
                Text = "❌ 加载失败",
                Duration = 2
            })
        end
    end)
    yOffset = yOffset + 55
    
    -- 6. 100次浪后(要卡密)
    CreateButton("🌊 100次浪后(要卡密)", yOffset, function()
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "cl hub",
            Text = "正在加载100次浪后...",
            Duration = 2
        })
        
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://pastefy.app/D9HHQKqH/raw"))()
        end)
        
        if success then
            game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "cl hub",
                Text = "✅ 加载成功",
                Duration = 2
            })
        else
            game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "cl hub",
                Text = "❌ 加载失败",
                Duration = 2
            })
        end
    end)
    yOffset = yOffset + 55
    
    -- 7. 森林中的99夜
    CreateButton("🌳 森林中的99夜", yOffset, function()
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "cl hub",
            Text = "正在加载森林中的99夜...",
            Duration = 2
        })
        
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest.lua", true))()
        end)
        
        if success then
            game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "cl hub",
                Text = "✅ 加载成功",
                Duration = 2
            })
        else
            game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "cl hub",
                Text = "❌ 加载失败",
                Duration = 2
            })
        end
    end)
    yOffset = yOffset + 55

    -- 8. 踩墙跳
    CreateButton("🧱 踩墙跳", yOffset, function()
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "cl hub",
            Text = "正在加载踩墙跳脚本...",
            Duration = 2
        })

        local success, err = pcall(function()
            loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-You-vs-home-wallhop-93874"))()
        end)

        if success then
            game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "cl hub",
                Text = "✅ 加载成功",
                Duration = 2
            })
        else
            game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "cl hub",
                Text = "❌ 加载失败",
                Duration = 2
            })
        end
    end)
    yOffset = yOffset + 55

    -- 9. 重新加载本脚本
    CreateButton("🔄 重新加载本脚本", yOffset, function()
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "cl hub",
            Text = "正在重新加载...",
            Duration = 2
        })
        wait(1)
        local a="https://cdn.jsdelivr.net/gh/vanengoo-oss/cl-hub-scripts/cl-hub-es.lua"
local b=game:HttpGet(a,true)
loadstring(b)()
    end)
yOffset = yOffset + 55
-- 10. 最强战场(卡密hung.gd)
CreateButton("💥 最强战场(卡密hung.gd)", yOffset, function()
    -- 提示加载中
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = "cl hub",
        Text  = "加载中...",
        Duration = 2
    })

    -- 异步拉脚本
    spawn(function()
        local ok, err = pcall(function()
            loadstring(game:HttpGet("https://rawscripts.net/raw/The-Strongest-Battlegrounds-Tsb-90979"))()
        end)

        if ok then
            game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "cl hub",
                Text  = "加载完成！",
                Icon  = "rbxassetid://105677776902677",
                Duration = 3
            })
        else
            game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "cl hub",
                Text  = "加载失败：" .. tostring(err):sub(1,50),
                Duration = 4
            })
        end
    end)
end)

-- 如果以后还要加按钮，记得把 yOffset 再 +55
yOffset = yOffset + 55
-- 11. 彩虹朋友
CreateButton("🌈 彩虹朋友", yOffset, function()
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = "cl hub",
        Text = "加载中...",
        Duration = 2
    })

    -- 异步拉脚本
    spawn(function()
        local ok, err = pcall(function()
            loadstring(game:HttpGet("https://gitlab.com/r_soft/main/-/raw/main/LoadUB.lua"))()
        end)

        if ok then
            game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "cl hub",
                Text = "✅ 加载成功",
                Duration = 3
            })
        else
            game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "cl hub",
                Text = "❌ 加载失败：" .. tostring(err):sub(1,50),
                Duration = 4
            })
        end
    end)
end)

yOffset = yOffset + 55
-- 12. 逃离海啸自动拿幸运方块(要卡密)
CreateButton("🎲 逃离海啸自动拿幸运方块(要卡密)", yOffset, function()
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = "cl hub",
        Text = "加载中...",
        Duration = 2
    })

    -- 异步拉脚本
    spawn(function()
        local ok, err = pcall(function()
            loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/2ce63cdc8b396e4d30d0e20e0215920ff0526c6b4a281c92db77177d2a8de9cf/download"))()
        end)

        if ok then
            game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "cl hub",
                Text = "✅ 加载成功",
                Duration = 3
            })
        else
            game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "cl hub",
                Text = "❌ 加载失败：" .. tostring(err):sub(1,50),
                Duration = 4
            })
        end
    end)
end)
yOffset = yOffset + 55
--13  踢走一个幸运方块
CreateButton("踢走一个幸运方块", yOffset, function()
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = "cl hub",
        Text = "加载中...",
        Duration = 2
    })

    -- 异步拉脚本
    spawn(function()
        local ok, err = pcall(function()
            loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/b750a01484e059e66de99715d47df7eb4a65baf9e71728591d136a9fe711132b/download"))()
        end)

        if ok then
            game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "cl hub",
                Text = "✅ 加载成功",
                Duration = 3
            })
        else
            game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "cl hub",
                Text = "❌ 加载失败：" .. tostring(err):sub(1,50),
                Duration = 4
            })
        end
    end)
end)
yOffset = yOffset + 55
    -- 显示语言菜单
    local function ShowLanguageMenu()
        if LanguageMenu then
            LanguageMenu:Destroy()
        end
        
        local LangGui = Instance.new("ScreenGui")
        LangGui.Name = "LanguageMenuUI"
        LangGui.Parent = PlayerGui
        LangGui.ResetOnSpawn = false
        
        local MenuFrame = Instance.new("Frame")
        MenuFrame.Parent = LangGui
        MenuFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
        MenuFrame.Position = UDim2.new(0.5, -75, 0.4, -75)
        MenuFrame.Size = UDim2.new(0, 150, 0, 150)
        MenuFrame.Active = true
        MenuFrame.Draggable = true
        
        local MenuCorner = Instance.new("UICorner")
        MenuCorner.CornerRadius = UDim.new(0, 8)
        MenuCorner.Parent = MenuFrame
        
        local MenuTitle = Instance.new("TextLabel")
        MenuTitle.Parent = MenuFrame
        MenuTitle.BackgroundTransparency = 1
        MenuTitle.Size = UDim2.new(1, 0, 0, 30)
        MenuTitle.Text = "🌐 选择语言"
        MenuTitle.TextColor3 = Color3.new(1, 1, 1)
        MenuTitle.TextSize = 14
        
        -- 中文按钮
        local ChineseBtn = Instance.new("TextButton")
        ChineseBtn.Parent = MenuFrame
        ChineseBtn.Position = UDim2.new(0.1, 0, 0.25, 0)
        ChineseBtn.Size = UDim2.new(0.8, 0, 0, 35)
        ChineseBtn.BackgroundColor3 = Color3.fromRGB(60, 100, 200)
        ChineseBtn.Text = "🇨🇳 中文"
        ChineseBtn.TextColor3 = Color3.new(1, 1, 1)
        
        local ChineseCorner = Instance.new("UICorner")
        ChineseCorner.CornerRadius = UDim.new(0, 6)
        ChineseCorner.Parent = ChineseBtn
        
        -- 西班牙语按钮
        local SpanishBtn = Instance.new("TextButton")
        SpanishBtn.Parent = MenuFrame
        SpanishBtn.Position = UDim2.new(0.1, 0, 0.6, 0)
        SpanishBtn.Size = UDim2.new(0.8, 0, 0, 35)
        SpanishBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 60)
        SpanishBtn.Text = "🇪🇸 Español"
        SpanishBtn.TextColor3 = Color3.new(1, 1, 1)
        
        local SpanishCorner = Instance.new("UICorner")
        SpanishCorner.CornerRadius = UDim.new(0, 6)
        SpanishCorner.Parent = SpanishBtn
        
        -- 按钮事件
        ChineseBtn.MouseButton1Click:Connect(function()
            game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "cl hub",
                Text = "已经是中文版本",
                Duration = 2
            })
            LangGui:Destroy()
        end)
        
        SpanishBtn.MouseButton1Click:Connect(function()
            game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "cl hub",
                Text = "正在切换到西班牙语版本...",
                Duration = 2
            })
            
            ScreenGui:Destroy()
            LangGui:Destroy()
            if MiniUI then MiniUI:Destroy() end
            
            wait(1)
            loadstring(game:HttpGet("https://pastebin.com/raw/giGkjTuP"))()
        end)
        
        LanguageMenu = LangGui
    end
    
    -- 绑定按钮事件
    LanguageBtn.MouseButton1Click:Connect(ShowLanguageMenu)
    
    MinimizeBtn.MouseButton1Click:Connect(function()
        ScreenGui.Enabled = false
        isMinimized = true
        
        if MiniUI then
            MiniUI.Enabled = true
        end
        
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "cl hub",
            Text = "窗口已缩小到左上角",
            Duration = 2
        })
    end)
    
    CloseBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
        if MiniUI then
            MiniUI:Destroy()
        end
        if LanguageMenu then
            LanguageMenu:Destroy()
        end
        
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "cl hub",
            Text = "脚本已关闭，感谢使用！",
            Duration = 2
        })
    end)
    
    MainUI = ScreenGui
    return ScreenGui
end

-- 创建UI
MainUI = CreateMainUI()
MiniUI = CreateMiniUI()

-- 功能实现
spawn(function()
    while wait(0.1) do
        if InfiniteJump then
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end
end)

spawn(function()
    while wait(0.1) do
        if Noclip then
            local char = game.Players.LocalPlayer.Character
            if char then
                for _, part in pairs(char:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end
    end
end)

-- 反挂机系统
pcall(function()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        wait(1)
        vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end)

-- 显示加载完成
local End = tick()
local LoadTime = End - Start

game:GetService("StarterGui"):SetCore("SendNotification",{
    Title = "cl hub 2026",
    Text = string.format("✅ 脚本加载完成！耗时: %.2f秒", LoadTime),
    Icon = "rbxassetid://105677776902677",
    Duration = 3
})

print("========================================")
print("cl hub 2026 - 完整中文版")
print("作者: 快手某人")
print("快手号: 3875377803")
print("功能: 完整功能 + 语言切换")
print("========================================")

-- 使用说明
wait(2)
game:GetService("StarterGui"):SetCore("SendNotification",{
    Title = "使用说明",
    Text = "1. 拖动标题栏移动窗口\n2. 点击 – 按钮缩小窗口\n3. 点击 × 按钮关闭脚本\n4. 点击 🌐 切换语言",
    Duration = 5
})
