print("Initializing Star Fall client...")

-- Set up event listeners
local PlayerController = require(script.PlayerController)
PlayerController.ConnectListeners()

-- Wait for character to load in
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
while char == nil do
    char = Player.Character
    wait(.1)
end
local controller = char:WaitForChild("Controller")

-- Initialize player's ship object
local CharacterController = require(controller.ControlScript)
CharacterController.Init()