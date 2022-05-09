local scriptService = game:GetService("ServerScriptService")
local workspace = game:GetService("Workspace")
local serverStorage = game:GetService("ServerStorage")
local fntns = scriptService.GameFunctions


-- Bindable functions
-----------------------------------------------------------------

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
	playerObj.Character = s
	workspace.GameFunctions.SetCamera:Invoke(playerObj, s.Engine)
	local c = game.ServerStorage["Ship Controlls"]:Clone()
	c.Parent = playerObj.Backpack
	playerObj.PlayerGui.LoadingGui.FadeOut:InvokeClient(playerObj)
end

function fntns.BuildShip.OnInvoke(shipName)

end