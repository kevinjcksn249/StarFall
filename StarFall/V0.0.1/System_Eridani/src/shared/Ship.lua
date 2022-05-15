
-- These values are suggestions for what your average, well-rounded gunship's stats should be
-- These default values should get overwritten when the player chooses a ship
-- NOTE: NEVER change values directly from another script. Values intended to be exposed to outside scripts can be changed with SetProperty()

local Ship = {
    -- Public properties
    Health = 100,                   -- Current health for the ship's hull
    MaxHealth = 100,                -- Max health for the ship's hull
    Shield = 100,                   -- Current health for the ship's shields
    MaxShield = 100,                -- Max health for the ship's shields
    MaxSpeed = 200,                 -- Cruising speed of the ship
    TurnSpeed = 50,                 -- How fast the ship turns
    ShieldRechargeInterval = 15,    -- Time in seconds representing how long the ship has to stop taking damage before the shields recharge
    ShieldRechargeAmount = 5,       -- Amount ship's shield recharges by every .1 secs while recharging
    ShieldRecharging = false,       -- Boolean indicating if the shield currently charging
    LaserDamage = 10,               -- Amount of damage done by each laser blast from the ship's turrets
    LaserFireRate = .1,             -- Wait time between laser blasts during a continuous salvo
    MissileLockedOn  = false,       -- Indicator of whether the ship is currently locked onto by a missile
    CharacterModel = nil,           -- Object reference to the Roblox model in the workspace
    
    -- Private properties
    Moving = false,                 -- Indicates if the ship is moving
    Turning = false,                -- Indicates if the ship is turning
    Destroyed = false,              -- Indicates the ship has been destroyed. Keeps the ship from being destroyed multiple times in one spawn
}
Ship.__index = Ship

-- Constructor
function Ship.new(maxHealth, maxShield, maxSpeed, turnSpeed, shieldInterval, shieldAmount, laserDamage, fireRate, model)
    local self = setmetatable({}, Ship)
    
    self.MaxHealth = maxHealth
    self.Health = maxHealth
    self.MaxShield = maxShield
    self.Shield = maxShield
    self.MaxSpeed = maxSpeed
    self.TurnSpeed = turnSpeed
    self.ShieldRechargeInterval = shieldInterval
    self.ShieldRechargeAmount = shieldAmount
    self.LaserDamage = laserDamage
    self.LaserFireRate = fireRate
    self.CharacterModel = model
    
    return self
end

-- This should set a physics object to start pushing the ship forward, 
-- and the trajectory should update when the ship changes without intervention
-- i.e: The physics object should work relative to the ship and not the workspace
function Ship:Advance()
    self.Moving = true
    self.CharacterModel.LinearVelocity.VectorVelocity = self.CharacterModel.HumanoidRootPart.CFrame.LookVector * self.MaxSpeed
end

-- Stops the ship from moving forward
function Ship:StopMoving()
    if not self.Moving then return end
    self.Moving = false
    self.CharacterModel.LinearVelocity.VectorVelocity = Vector3.new(0,0,0)
end

-- Causes the ship to start turning left
function Ship:TurnLeft()
    if self.Turning then return end
    self.Turning = true
    self.CharacterModel.AngularVelocity.AngularVelocity = Vector3.new(0, self.TurnSpeed, 0)
end

-- Causes the ship to start turning right
function Ship:TurnRight()
    if self.Turning then return end
    self.Turning = true
    self.CharacterModel.AngularVelocity.AngularVelocity = Vector3.new(0, self.TurnSpeed * -1, 0)
end

-- Causes the ship to stop turning
function Ship:StopTurning()
    if not self.Turning then return end
    self.Turning = false
    self.CharacterModel.AngularVelocity.AngularVelocity = Vector3.new(0,0,0)
    if self.Moving then
        self:Advance()
    end
end

-- Deal damage to the ship
function Ship:Damage(intDmgAmount)
    self.Recharging = false
    if self.Shield > 0 then
        if intDmgAmount > self.Shield then
            rem = intDmgAmount - self.Shield
            self:SetProperty("Shield", 0)
            self:SetProperty("Health", self.Health - rem)
        elseif intDmgAmount <= self.Shield then
            self:SetProperty("Shield", self.Shield - intDmgAmount)
        end
    elseif self.Health > 0 then
        self:SetProperty("Health", self.Health - intDmgAmount)
    end
    if self.Health == 0 then
        self.CharacterModel.Destroyed:Fire()
    end
end

-- Destroy the ship
function Ship:Destroy()
    if self.Destroyed then return end
    self.Destroyed = true -- Should be the only time this variable is set to true, and it should NEVER be set false outside a constructor
    print("Ship destroyed!")
end

-- Recharge the ship's shields
function Ship:Recharge()
    self.Recharging = true
    for i = 1, self.ShieldRechargeInterval do
        for i = 1, 100 do
            wait(.01)
            if not self.Recharging then return end
        end     
    end

    while self.Shield < self.MaxShield do
        for i = 1, 10 do
            wait(.01)
            if not self.Recharging then return end
        end
        self:SetProperty("Shield", self.Shield + self.ShieldRechargeAmount)
    end
end


-- Set one of the ship's properties
function Ship:SetProperty(strProp, intValue)
    self[strProp] = intValue
    self.CharacterModel:SetAttribute(strProp, intValue)
    
    -- Limit 0 < shield/health < MaxShield/MaxHealth
    if strProp == "Shield" then
        if self[strProp] < 0 then
            self:SetProperty(strProp, 0)
        elseif self[strProp] > self.MaxShield then
            self:SetProperty(self.MaxShield)
        end
    elseif strProp == "Health" then
        if self[strProp] < 0 then
            self:SetProperty(strProp, 0)
        elseif self[strProp] > self.MaxHealth then
            self:SetProperty(strProp, self.MaxHealth)
        end
    end
end

return Ship