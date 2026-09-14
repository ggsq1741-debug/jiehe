-- This script was generated using MoonVeil 2.0.24 [https://moonveil.cc]
local WindUI=loadstring(game:HttpGet"https://github.com/Footagesus/WindUI/releases/latest/download/main.lua")()
local Window=WindUI:CreateWindow{
    Title="\229\138\160\232\189\189\233\133\141\231\189\174",
    Author="\230\184\175\231\140\171\228\184\173\229\155\189\229\184\140\230\156\155",
    Icon="https://raw.githubusercontent.com/ggsq1741-debug/BAL/refs/heads/main/080ac076-1d58-4f85-9683-17bf5f1aa0b7.png",
    Folder="MyHub",
    Size=UDim2 .fromOffset(500,400),
    Theme="Dark",
    Transparent=true,
    SideBarWidth=150,
    User={
        Enabled=true
    },
    ToggleKey=Enum.KeyCode.RightShift
}
local Tabs={
    wj=Window:Tab{
        Title="\232\132\154\230\156\172\229\138\160\232\189\189\233\133\141\231\189\174\233\128\137\230\139\169\228\184\164\228\184\170\233\133\141\231\189\174\229\143\170\231\148\168\233\128\137\228\184\128\228\184\170",
        Icon="users"
    }
}
Tabs.wj:Button{
    Title="ChronixUI\229\138\160\232\189\189",
    Callback=function()
        loadstring(game:HttpGet"https://raw.githubusercontent.com/ggsq1741-debug/pz2/refs/heads/main/ChronixUI.lua")()
    end
}
Tabs.wj:Button{
    Title="WindUI\229\138\160\232\189\189",
    Callback=function()
        loadstring(game:HttpGet"https://raw.githubusercontent.com/ggsq1741-debug/Wind1/refs/heads/main/WindUI.lua")()
    end
}
Tabs.wj:Button{
    Title="ChronixUI\229\138\160\232\189\189\229\143\175\228\187\165\228\191\157\229\173\152\233\133\141\231\189\174",
    Callback=function()
        loadstring(game:HttpGet"https://raw.githubusercontent.com/ggsq1741-debug/ObsidianUI/refs/heads/main/Obsidian%20UI.lua")()
    end
}
Window:SelectTab(1)