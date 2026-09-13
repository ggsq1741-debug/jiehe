-- ==================== 加载 WindUI ====================
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-- ==================== 创建窗口 ====================
local Window = WindUI:CreateWindow({
    Title = "加载配置",
    Author = "港猫的通缉",
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
    wj = Window:Tab({ Title = "脚本加载配置选择两个配置只用选一个", Icon = "users" }), 
}
-- ==================== 主功能页 ====================
Tabs.wj:Button({
     Title = "ChronixUI加载",
     Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/ggsq1741-debug/BAL/refs/heads/main/Kero.lua"))()
     end
 })
Tabs.wj:Button({
     Title = "WindUI加载",
     Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/ggsq1741-debug/BAL/refs/heads/main/obfuscated.lua"))()
     end
 })
 
 Window:SelectTab(1)