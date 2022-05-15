--[[
    Client-side component of ship controls. Listens for key input events and issues remote calls to control ship based on those events
]]

local Players = game:GetService("Players")
local PlayerController = {}


-- White-lists key inputs. To add a key to input detection, add a case for it to this function
local function isRelevantInput(input)
    return (
        input.KeyCode == Enum.KeyCode.W
        or input.KeyCode == Enum.KeyCode.A
        or input.KeyCode == Enum.KeyCode.S
        or input.KeyCode == Enum.KeyCode.D
        or input.KeyCode == Enum.KeyCode.F
        
    );
end

-- Registers key-press event listeners and invokes the relevant functions
local function registerKeyPressed(input, gameProcessedEvent)
    local player = Players.LocalPlayer
    local ship = player.Character
    if gameProcessedEvent or not isRelevantInput(input) then
        return;
    end

    if input.KeyCode == Enum.KeyCode.W then
        ship.Advance:Invoke()
    end

    if input.KeyCode == Enum.KeyCode.A then
        ship.TurnLeft:Invoke()
    end

    if input.KeyCode == Enum.KeyCode.D then
        ship.TurnRight:Invoke()
    end
end

-- Registers key-release event listeners and invokes the relevant functions
local function registerKeyReleased(input, gameProcessedEvent)
    local player = Players.LocalPlayer
    local ship = player.Character
    if gameProcessedEvent or not isRelevantInput(input) then
        return;
    end

    if input.KeyCode == Enum.KeyCode.W then
        ship.StopMoving:Invoke()
    end

    if input.KeyCode == Enum.KeyCode.A or input.KeyCode == Enum.KeyCode.D then
        ship.StopTurning:Invoke()
    end
end

-- Public function that connects the event listeners. Must be called every time a player spawns
function PlayerController.ConnectListeners()
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")

    UserInputService.InputBegan:Connect(registerKeyPressed)
    UserInputService.InputEnded:Connect(registerKeyReleased)
end

return PlayerController

