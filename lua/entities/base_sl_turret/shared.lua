ENT.Type 			= "anim"
ENT.Base 			= "base_anim"

ENT.Category		= "Star Wars asdasd Emplacements"
ENT.PrintName 		= "E-Web Blaster asdasdasdasdCannon"
ENT.Author			= "Venator"
ENT.Spawnable		= true
ENT.AdminSpawnable	= false
ENT.Constructor = true

function ENT:SetupDataTables()
	self:NetworkVar("Float", 0, "FakeHealth")


	if SERVER then
		self:SetFakeHealth(100)
	end
end

function ENT:Use(activator,caller)
	-- Put a check here to see if there are any guns left on the base of the gun

	local guns = false

	for index, ent in pairs(self.GunParts) do
		if IsValid(ent) then
			guns = true
			break
		end
	end
	if guns then return end

	self:Remove() -- It is safe to remove the base give a base ammo back to the player
end


function ENT:Think()

end	