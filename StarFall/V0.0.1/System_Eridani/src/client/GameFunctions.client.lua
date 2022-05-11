local workspace = game:GetService("Workspace")
local replicatedStorage = game:GetService("ReplicatedStorage")
local fntns = replicatedStorage.GameFunctions


-- Called by player gui's spawn script
function fntns.SpawnPlayer.OnInvoke(playerObj, shipObj)
	-- Fade player's loading gui in
	playerObj.PlayerGui.LoadingGui.FadeIn:InvokeClient(playerObj)

	-- Spawn in the player's ship
	local s = shipObj:Clone()
	s.Parent = workspace

	-- Give ship player's name
	s.NameTag.gui.lbl.Text = playerObj.Name

	-- Move the ship to the spawn location decided on by the gui
	s:MoveTo(playerObj.PlayerGui.ShipSelectGui.Destination.Value.Position)

	-- Set player's character to ship, so the camera knows what to follow, then move the camera
	playerObj.Character = s
	workspace.GameFunctions.SetCamera:Invoke(playerObj, s.Engine)

	-- Create a new control tool and give it to the player
	local c = game.ServerStorage["Ship Controlls"]:Clone()
	c.Parent = playerObj.Backpack

	-- Fade out the loading gui
	playerObj.PlayerGui.LoadingGui.FadeOut:InvokeClient(playerObj)
end
