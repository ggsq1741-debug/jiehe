-- ==========================================
-- BAL 港猫脚本辅助 · HUD 科技风启动动画 (极速消散版)
-- ==========================================
local function playBALIntro()
    local TweenService = game:GetService("TweenService")
    local RunService   = game:GetService("RunService")
    local LP           = game:GetService("Players").LocalPlayer
    local parent       = (gethui and gethui()) or LP:WaitForChild("PlayerGui")

    -- 高级配色
    local cyan  = Color3.fromRGB(0, 255, 200)
    local white = Color3.fromRGB(255, 255, 255)
    local dark  = Color3.fromRGB(8, 10, 14)

    local old = parent:FindFirstChild("BAL_Intro")
    if old then old:Destroy() end

    local gui = Instance.new("ScreenGui")
    gui.Name = "BAL_Intro"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.DisplayOrder = 99999
    gui.Parent = parent

    -- 1. 深邃暗黑背景
    local bg = Instance.new("Frame")
    bg.Size = UDim2.fromScale(1, 1)
    bg.BackgroundColor3 = dark
    bg.BackgroundTransparency = 1
    bg.BorderSizePixel = 0
    bg.ZIndex = 1
    bg.Parent = gui

    -- 2. 屏幕四角的 HUD 装饰线
    local function createBracket(anchorX, anchorY, rot)
        local b = Instance.new("Frame")
        b.AnchorPoint = Vector2.new(anchorX, anchorY)
        b.Position = UDim2.new(anchorX, -anchorX*40 + anchorX*20, anchorY, -anchorY*40 + anchorY*20)
        b.Size = UDim2.new(0, 60, 0, 60)
        b.BackgroundTransparency = 1
        b.ZIndex = 2
        b.Parent = gui
        
        local l1 = Instance.new("Frame", b)
        l1.Size = UDim2.new(0, 2, 0, 60)
        l1.Position = UDim2.new(0, 0, 0, 0)
        l1.BackgroundColor3 = cyan
        l1.BackgroundTransparency = 0.7
        
        local l2 = Instance.new("Frame", b)
        l2.Size = UDim2.new(0, 60, 0, 2)
        l2.Position = UDim2.new(0, 0, 0, 0)
        l2.BackgroundColor3 = cyan
        l2.BackgroundTransparency = 0.7
        
        b.Rotation = rot
        return b
    end
    local br1 = createBracket(0, 0, 0)
    local br2 = createBracket(1, 0, 90)
    local br3 = createBracket(1, 1, 180)
    local br4 = createBracket(0, 1, 270)

    -- 3. 核心容器
    local holder = Instance.new("Frame")
    holder.AnchorPoint = Vector2.new(0.5, 0.5)
    holder.Position = UDim2.fromScale(0.5, 0.5)
    holder.Size = UDim2.fromOffset(300, 300)
    holder.BackgroundTransparency = 1
    holder.ZIndex = 4
    holder.Parent = gui
    local uiscale = Instance.new("UIScale")
    uiscale.Scale = 0
    uiscale.Parent = holder

    -- 4. 多边形生成器
    local allEdges = {}
    local layerFrames = {}
    
    local function createPolygon(sides, radius, thickness, transparency, zIndex)
        local layer = Instance.new("Frame")
        layer.AnchorPoint = Vector2.new(0.5, 0.5)
        layer.Position = UDim2.fromScale(0.5, 0.5)
        layer.Size = UDim2.fromOffset(300, 300)
        layer.BackgroundTransparency = 1
        layer.ZIndex = zIndex
        layer.Parent = holder
        table.insert(layerFrames, layer)

        local angleStep = 360 / sides
        local edgeLength = 2 * radius * math.sin(math.rad(angleStep / 2))
        local distance = radius * math.cos(math.rad(angleStep / 2))

        for k = 0, sides - 1 do
            local ang = math.rad((angleStep / 2) + angleStep * k)
            local mx = 150 + distance * math.cos(ang)
            local my = 150 + distance * math.sin(ang)

            local edge = Instance.new("Frame")
            edge.AnchorPoint = Vector2.new(0.5, 0.5)
            edge.Position = UDim2.fromOffset(mx, my)
            edge.Size = UDim2.fromOffset(0, thickness)
            edge.Rotation = math.deg(ang) + 90
            edge.BackgroundColor3 = cyan
            edge.BackgroundTransparency = transparency
            edge.BorderSizePixel = 0
            edge.ZIndex = zIndex
            edge.Parent = layer
            local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(1, 0); c.Parent = edge
            
            table.insert(allEdges, {
                Frame = edge,
                TargetLength = edgeLength + 2
            })
        end
        return layer
    end

    createPolygon(8, 130, 1, 0.85, 4)  -- 极细八边形
    createPolygon(12, 95, 2, 0.6, 5)   -- 中十二边形
    local innerHex = createPolygon(6, 60, 3, 0.1, 6) -- 高光六边形核心

    -- 5. 中心文字与状态
    local textGroup = Instance.new("Frame")
    textGroup.AnchorPoint = Vector2.new(0.5, 0.5)
    textGroup.Position = UDim2.fromScale(0.5, 0.5)
    textGroup.Size = UDim2.fromOffset(200, 100)
    textGroup.BackgroundTransparency = 1
    textGroup.ZIndex = 10
    textGroup.Parent = holder

    local balText = Instance.new("TextLabel")
    balText.AnchorPoint = Vector2.new(0.5, 0.5)
    balText.Position = UDim2.fromScale(0.5, 0.4)
    balText.Size = UDim2.fromScale(1, 0.6)
    balText.BackgroundTransparency = 1
    balText.Text = "B A L"
    balText.Font = Enum.Font.GothamBlack
    balText.TextSize = 38
    balText.TextColor3 = white
    balText.TextTransparency = 1
    balText.ZIndex = 11
    balText.Parent = textGroup

    local textStroke = Instance.new("UIStroke", balText)
    textStroke.Color = cyan
    textStroke.Thickness = 1.5
    textStroke.Transparency = 0.5

    local statusText = Instance.new("TextLabel")
    statusText.AnchorPoint = Vector2.new(0.5, 0.5)
    statusText.Position = UDim2.fromScale(0.5, 0.85)
    statusText.Size = UDim2.new(1, 0, 0, 15)
    statusText.BackgroundTransparency = 1
    statusText.Text = "[ 等待授权 ]"
    statusText.Font = Enum.Font.Code
    statusText.TextSize = 11
    statusText.TextColor3 = cyan
    statusText.TextTransparency = 1
    statusText.ZIndex = 11
    statusText.Parent = textGroup

    -- 6. 欢迎祝福语
    local welcomeText = Instance.new("TextLabel")
    welcomeText.AnchorPoint = Vector2.new(0.5, 0.5)
    welcomeText.Position = UDim2.new(0.5, 0, 0.5, 135)
    welcomeText.Size = UDim2.fromOffset(350, 20)
    welcomeText.BackgroundTransparency = 1
    welcomeText.Text = "欢迎使用港猫辅助，祝你天天开心"
    welcomeText.Font = Enum.Font.GothamMedium
    welcomeText.TextSize = 14
    welcomeText.TextColor3 = white
    welcomeText.TextTransparency = 1
    welcomeText.ZIndex = 5
    welcomeText.Parent = gui

    local welcomeStroke = Instance.new("UIStroke", welcomeText)
    welcomeStroke.Color = cyan
    welcomeStroke.Thickness = 1
    welcomeStroke.Transparency = 0.7

    -- 7. 底部精细加载条
    local loadBarGroup = Instance.new("Frame")
    loadBarGroup.AnchorPoint = Vector2.new(0.5, 0.5)
    loadBarGroup.Position = UDim2.new(0.5, 0, 0.5, 170)
    loadBarGroup.Size = UDim2.fromOffset(260, 20)
    loadBarGroup.BackgroundTransparency = 1
    loadBarGroup.ZIndex = 5
    loadBarGroup.Parent = gui

    local barBack = Instance.new("Frame")
    barBack.AnchorPoint = Vector2.new(0.5, 0.5)
    barBack.Position = UDim2.fromScale(0.5, 0.5)
    barBack.Size = UDim2.new(1, 0, 0, 2)
    barBack.BackgroundColor3 = Color3.fromRGB(30, 40, 45)
    barBack.BorderSizePixel = 0
    barBack.ZIndex = 5
    barBack.Parent = loadBarGroup
    
    local barFill = Instance.new("Frame")
    barFill.AnchorPoint = Vector2.new(0, 0.5)
    barFill.Position = UDim2.fromScale(0, 0.5)
    barFill.Size = UDim2.fromScale(0, 1)
    barFill.BackgroundColor3 = cyan
    barFill.BorderSizePixel = 0
    barFill.ZIndex = 6
    barFill.Parent = barBack

    local percentText = Instance.new("TextLabel")
    percentText.AnchorPoint = Vector2.new(0, 0.5)
    percentText.Position = UDim2.new(0, 0, 0.5, -12)
    percentText.Size = UDim2.fromOffset(50, 12)
    percentText.BackgroundTransparency = 1
    percentText.Text = "0%"
    percentText.Font = Enum.Font.Code
    percentText.TextSize = 12
    percentText.TextColor3 = cyan
    percentText.TextXAlignment = Enum.TextXAlignment.Left
    percentText.TextTransparency = 1
    percentText.ZIndex = 6
    percentText.Parent = loadBarGroup

    local loadingLabel = Instance.new("TextLabel")
    loadingLabel.AnchorPoint = Vector2.new(1, 0.5)
    loadingLabel.Position = UDim2.new(1, 0, 0.5, -12)
    loadingLabel.Size = UDim2.fromOffset(100, 12)
    loadingLabel.BackgroundTransparency = 1
    loadingLabel.Text = "LOADING..."
    loadingLabel.Font = Enum.Font.Code
    loadingLabel.TextSize = 12
    loadingLabel.TextColor3 = white
    loadingLabel.TextXAlignment = Enum.TextXAlignment.Right
    loadingLabel.TextTransparency = 1
    loadingLabel.ZIndex = 6
    loadingLabel.Parent = loadBarGroup

    -- ⭐ 8. 动态渲染循环
    local alive = true
    local timeAcc = 0
    local spinSpeed = 1
    
    RunService.RenderStepped:Connect(function(dt)
        if not alive then return end
        timeAcc = timeAcc + dt

        layerFrames[1].Rotation = layerFrames[1].Rotation + dt * 10 * spinSpeed
        layerFrames[2].Rotation = layerFrames[2].Rotation - dt * 20 * spinSpeed
        layerFrames[3].Rotation = layerFrames[3].Rotation + dt * 35 * spinSpeed

        local pulse = 1 + math.sin(timeAcc * 6) * 0.03
        layerFrames[3].Size = UDim2.fromOffset(300 * pulse, 300 * pulse)
        
        local edgeGlow = 0.1 + math.sin(timeAcc * 4) * 0.2
        for _, v in ipairs(layerFrames[3]:GetChildren()) do
            if v:IsA("Frame") then
                v.BackgroundTransparency = edgeGlow
            end
        end
        
        if welcomeText.TextTransparency < 1 then
            welcomeText.TextTransparency = 0.1 + math.sin(timeAcc * 2) * 0.1
        end
    end)

    -- 9. 时间轴动画
    task.spawn(function()
        TweenService:Create(bg, TweenInfo.new(0.5, Enum.EasingStyle.Sine), { BackgroundTransparency = 0 }):Play()
        task.wait(0.3)

        TweenService:Create(uiscale, TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Scale = 1 }):Play()

        for i, data in ipairs(allEdges) do
            local randomDelay = math.random(1, 10) / 100 
            task.delay(randomDelay, function()
                TweenService:Create(data.Frame, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Size = UDim2.fromOffset(data.TargetLength, data.Frame.Size.Y.Offset)
                }):Play()
            end)
        end
        task.wait(0.6)

        TweenService:Create(balText, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { TextTransparency = 0 }):Play()
        TweenService:Create(welcomeText, TweenInfo.new(0.8), { TextTransparency = 0.1 }):Play()
        TweenService:Create(statusText, TweenInfo.new(0.6), { TextTransparency = 0 }):Play()
        TweenService:Create(percentText, TweenInfo.new(0.4), { TextTransparency = 0 }):Play()
        TweenService:Create(loadingLabel, TweenInfo.new(0.4), { TextTransparency = 0 }):Play()
        task.wait(0.4)

        local states = {"[ 校验环境... ]", "[ 注入组件... ]", "[ 开启安全通道... ]"}
        for i, state in ipairs(states) do
            statusText.Text = state
            task.wait(0.45)
        end

        local loadTime = 1.5
        TweenService:Create(barFill, TweenInfo.new(loadTime, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), { Size = UDim2.fromScale(1, 1) }):Play()
        
        local tickRate = 0.03
        local steps = loadTime / tickRate
        for i = 0, 100, (100 / steps) do
            if not alive then break end
            percentText.Text = string.format("%03d%%", math.floor(i))
            task.wait(tickRate)
        end
        
        -- ⭐ 10. 100% 终极能量爆闪 & 极速消散
        percentText.Text = "100%"
        loadingLabel.Text = "INJECTED"
        loadingLabel.TextColor3 = cyan
        statusText.Text = "[ 注入成功 ]"
        statusText.TextColor3 = white
        
        balText.TextColor3 = white
        welcomeText.TextColor3 = cyan
        TweenService:Create(textStroke, TweenInfo.new(0.05), { Color = white, Thickness = 3 }):Play()
        TweenService:Create(welcomeStroke, TweenInfo.new(0.05), { Color = white, Transparency = 0 }):Play()

        for _, layer in ipairs(layerFrames) do
            for _, v in ipairs(layer:GetChildren()) do
                if v:IsA("Frame") then
                    TweenService:Create(v, TweenInfo.new(0.05), { BackgroundColor3 = white, BackgroundTransparency = 0 }):Play()
                end
            end
        end

        -- 极短的闪白，仅维持 0.15 秒
        spinSpeed = 6
        task.wait(0.15)

        -- ⭐ 瞬间切断视觉，绝不拖泥带水
        alive = false
        
        -- 1. 极速淡出所有内容 (0.15秒)
        local fastFade = TweenInfo.new(0.15, Enum.EasingStyle.Linear)
        TweenService:Create(balText, fastFade, { TextTransparency = 1 }):Play()
        TweenService:Create(welcomeText, fastFade, { TextTransparency = 1 }):Play()
        TweenService:Create(statusText, fastFade, { TextTransparency = 1 }):Play()
        TweenService:Create(percentText, fastFade, { TextTransparency = 1 }):Play()
        TweenService:Create(loadingLabel, fastFade, { TextTransparency = 1 }):Play()
        TweenService:Create(barBack, fastFade, { BackgroundTransparency = 1 }):Play()
        TweenService:Create(barFill, fastFade, { BackgroundTransparency = 1 }):Play()
        TweenService:Create(bg, fastFade, { BackgroundTransparency = 1 }):Play()

        for _, layer in ipairs(layerFrames) do
            for _, v in ipairs(layer:GetChildren()) do
                if v:IsA("Frame") then
                    TweenService:Create(v, fastFade, { BackgroundTransparency = 1 }):Play()
                end
            end
        end
        
        local bFade = TweenInfo.new(0.15, Enum.EasingStyle.Linear)
        for _, br in ipairs({br1, br2, br3, br4}) do
            for _, child in ipairs(br:GetChildren()) do
                if child:IsA("Frame") then
                    TweenService:Create(child, bFade, { BackgroundTransparency = 1 }):Play()
                end
            end
        end

        TweenService:Create(uiscale, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.In), { Scale = 0 }):Play()
        
        task.delay(0.2, function()
            if gui then
                gui:Destroy()
            end
        end)
    end)
end

-- 执行
pcall(playBALIntro)
-- ==================== 加载 WindUI ====================
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-- ==================== 创建窗口 ====================
local Window = WindUI:CreateWindow({
    Title = "加载配置",
    Author = "港猫中国希望",
    Icon = "https://raw.githubusercontent.com/ggsq1741-debug/BAL/refs/heads/main/080ac076-1d58-4f85-9683-17bf5f1aa0b7.png", 
    Folder = "MyHub",
    Size = UDim2.fromOffset(500, 400),
    Theme = "Dark",
    Transparent = true,
    SideBarWidth = 150,
    User = { Enabled = true },
    ToggleKey = Enum.KeyCode.RightShift,
})

-- ==================== 创建标签页 ====================
local Tabs = {
    wj = Window:Tab({ Title = "脚本加载配置最后3个配置只用选一个", Icon = "users" }), 
}
-- ==================== 主功能页 ====================
Tabs.wj:Code({
    Title = "你好",
    Code = "此脚本售价仅为15元"
})
 Tabs.wj:Button({
     Title = "AifflowUI简洁精简版",
     Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/ggsq1741-debug/cQ/refs/heads/main/gangmao.lua"))()
     end
 })
Tabs.wj:Button({
     Title = "WindUI加载✅",
     Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/ggsq1741-debug/Wind1/refs/heads/main/WindUI3.lua"))()
     end
 })
 Tabs.wj:Button({
     Title = "ObsidianUI加载可以保存配置✅",
     Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/ggsq1741-debug/ObsidianUI/refs/heads/main/Obsidian3.lua"))()
     end
 })
 Tabs.wj:Button({
     Title = "ouroborosUI最佳的方式✅",
     Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/ggsq1741-debug/ouroborosUI/refs/heads/main/3ji%E6%B7%B7%E6%B7%86.lua"))()
     end
 })
 Window:SelectTab(1)