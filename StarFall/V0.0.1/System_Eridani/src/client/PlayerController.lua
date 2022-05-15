--[[
    Client-side component of ship controls. Listens for key input events and issues remote calls to control ship based on those events
]]


local PlayerController = {}

local function isRelevantInput(input)
    return (
        input.KeyCode == Enum.KeyCode.W
        or input.KeyCode == Enum.KeyCode.A
        or input.KeyCode == Enum.KeyCode.S
        or input.KeyCode == Enum.KeyCode.D
        or input.KeyCode == Enum.KeyCode.F
        
    );
end

local function registerKeyPressed(input, gameProcessedEvent)
    local player = script.Parent.Parent.Parent
    local ship = player.Character
    if gameProcessedEvent or not isRelevantInput(input) then
        return;
    end

    if input.KeyCode == Enum.KeyCode.W then
        print("W key pressed")
        ship.Advance:Invoke()
    end


end

function PlayerController.ConnectListeners()
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")

    UserInputService.InputBegan:Connect(registerKeyPressed)
end

return PlayerController

