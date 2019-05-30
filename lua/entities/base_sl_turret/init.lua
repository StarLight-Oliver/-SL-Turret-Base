AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

ENT.Parts = {
	[1] = {
		Pos = function(self, them)
			return them:GetAngles():Up() * 20
		end,
		Angle = Angle(0,0,0), -- This is the offest angle of the person
		RotationLock = -1,
	},
}

ENT.GunParts = {} -- DON'T ADD THIS, this is used internally


--self:SetModel("models/sw_battlefront/props/e-web_turret/e-web_turret.mdl")  This is a gun base
function ENT:Initialize()
	-- This accepts any model or the default model if required
	self.GunParts = {}
	self:SetModel(self.Model || "models/props_c17/FurnitureDrawer001a.mdl") 
	
	
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	--self:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
	
	local phys = self.Entity:GetPhysicsObject()

	
	if IsValid( phys ) then
	
		phys:Wake()
		phys:SetVelocity( Vector( 0, 0, 0 ) )
	end

	self.ShadowParams = {}
	self:DropToFloor()
end


function ENT:PhysicsSimulate( phys, deltatime )
end
