-- Client initializer that runs once when a player connects to the game

print("Initializing Star Fall client...")

-- Set up event listeners
local PlayerController = require(script.PlayerController)
PlayerController.ConnectListeners()

-- TODO: Everything below this point will need to be moved to the ship chooser gui controls to enable respawning

-- Wait for character to load in
local Players = game:GetService("Players")
local player = Players.LocalPlayer
while char == nil do
    char = player.Character
    wait(.1)
end
local controller = char:WaitForChild("Controller")

-- Initialize player's ship object
local CharacterController = require(controller.ShipControlScript)
CharacterController.Init()

-- Set camera subject to player's character
workspace.CurrentCamera.CameraSubject = player.Character

-- In the future, it would be interesting to develop a custom player camera control script
-- Guide for doing this can be found here: https://developer.roblox.com/en-us/articles/Camera-manipulation
workspace.CurrentCamera.CameraType = Enum.CameraType.Custom 
