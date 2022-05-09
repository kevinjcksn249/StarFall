local scriptService = game:GetService("ServerScriptService")
local fntns = scriptService.GameFunctions

-- Bindable functions
-----------------------------------------------------------------
function fntns.SpawnPlayer.OnInvoke(player, ship)
	player.PlayerGui.LoadingGui.FadeIn:InvokeClient(player)

	local s = ship:Clone()
	s.Parent = workspace
	s.NameTag.gui.lbl.Text = player.Name
	s:MoveTo(player.PlayerGui.ShipSelectGui.Destination.Value.Position)
	player.Character = s
	workspace.GameFunctions.SetCamera:Invoke(player, s.Engine)
	local c = game.ServerStorage["Ship Controlls"]:Clone()
	c.Parent = player.Backpack
	player.PlayerGui.LoadingGui.FadeOut:InvokeClient(player)

end
