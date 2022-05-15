-- Control interface for ship class
local character = script.Parent.Parent
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Ship = require(ReplicatedStorage.Common.Ship)
local ShipObj = {}
ShipObj.__Index = ShipObj

-- Definitions for the player character's bindable and remote functions
function character.Advance.OnInvoke()
	ShipObj:Advance()
end

function character.StopMoving.OnInvoke()
	ShipObj:StopMoving()
end

function character.TurnLeft.OnInvoke()
	ShipObj:TurnLeft()
end

function character.TurnRight.OnInvoke()
	ShipObj:TurnRight()
end

function character.StopTurning.OnInvoke()
	ShipObj:StopTurning()
end

-- Definitions for the player character's internal bindable and remote event listeners
local function onDamaged(intAmount)
	ShipObj:Damage(intAmount)
	wait(.1)
	ShipObj:Recharge()
end

local function onDestroyed()
	ShipObj:Destroy()
end

-- Initializes the ship object.
-- TODO: in the future, this code should run when called by ShipSelectGui, not the client initializer
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
	character.Damaged.Event:connect(onDamaged)
	character.Destroyed.Event:connect(onDestroyed)
end

return ShipObj