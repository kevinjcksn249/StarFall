local character = script.Parent.Parent
local ServerScriptService = game:GetService("ServerScriptService")
local Ship = require(ServerScriptService.Server.Ship)
local ShipObj = nil

function character.Advance.OnInvoke()
    ShipObj:Advance()
end

-- Initializes the ship object.
-- TODO: in the future, this code should run when called by ShipSelectGui, not when the script first loads
function Init()
    ShipObj = Ship.new(
        character.Attributes.MaxHealth, 
        character.Attributes.MaxShield, 
        character.Attributes.Speed, 
        character.Attributes.TurnSpeed, 
        character.Attributes.ShieldRechargeInterval, 
        character.Attributes.ShieldRechargeAmount, 
        character.Attributes.LaserDamage, 
        character.Attributes.LaserFireRate,
        character
    )
end

Init()
