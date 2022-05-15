local character = script.Parent.Parent
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Ship = require(ReplicatedStorage.Common.Ship)
local ShipObj = {}
ShipObj.__Index = ShipObj


function character.Advance.OnInvoke()
	print("Advance method invoked")
    ShipObj:Advance()
end

-- Initializes the ship object.
-- TODO: in the future, this code should run when called by ShipSelectGui, not when the script first loads
function ShipObj.Init()
    ShipObj = Ship.new(
        character:GetAttribute("MaxHealth"), 
		character:GetAttribute("MaxShield"), 
        character:GetAttribute("Speed"), 
		character:GetAttribute("TurnSpeed"), 
		character:GetAttribute("ShieldRechargeInterval"), 
		character:GetAttribute("ShieldRechargeAmount"), 
		character:GetAttribute("LaserDamage"), 
		character:GetAttribute("LaserFireRate"),
        character
    )
end

return ShipObj