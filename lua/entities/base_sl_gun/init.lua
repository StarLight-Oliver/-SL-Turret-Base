AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

ENT.Offest = {
	Pos = Vector(0,0,0),
	Angle = Angle(0,0,0), -- Don't touch it won't change much
}

function ENT:Initialize()
	-- This accepts any model or the default model if required
	self.Offest = {
		Pos = self.Offest.Pos,
		Angle = self.Offest.Angle


}
	self:SetModel(self.Model || "models/sw_battlefront/props/e-web_turret/e-web_turret.mdl") 
	
	
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	--self:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
	print("Hi")
	local phys = self.Entity:GetPhysicsObject()
	local en = nil
	local slot = nil
	PrintTable(ents.FindInSphere(self:GetPos(), 100))
	print("Starting For loop")
	for index, ent in pairs(ents.FindInSphere(self:GetPos(), 100) ) do 
		if ent:GetClass() == "base_sl_turret" or ent.Base == "base_sl_turret" then
			
			print("Ent is the right class ")
			print(ent, #ent.Parts)
			for x = 1, #ent.Parts do
				print("Doom")
				print(IsValid(ent.GunParts[x]) , ent.GunParts[x])
				if !IsValid(ent.GunParts[x]) then
					
					print(x, ent)
					slot = x
					en = ent
					break
				end
			end
			print(en, slot)
			if IsValid(en) then 
				print(en, " this is the ent we found")
				break 
			end
		end
	end

	if IsValid(en) then
		if slot then
			self.BasePos = en
			--self:SetParent(en)
			self:SetGunSlot(slot)
			en.GunParts[slot] = self 
			
			self.collide =constraint.NoCollide(self,en,0,0)

		end
	end

	if IsValid( phys ) then
	
		phys:Wake()
		phys:SetVelocity( Vector( 0, 0, 0 ) )
	end

	self.ShadowParams = {}
	
	self:StartMotionController()
	self.ShotSound=Sound("gun")
	self:SetUseType(SIMPLE_USE)
	self.MuzzleAttachment=self:LookupAttachment("muzzle")
	self.HookupAttachment=self:LookupAttachment("hookup")	
end



function ENT:OnRemove()

	if IsValid(self:GetShooter()) then
		self:GetShooter():SetTurret(false)
		self:SetShooter(nil)
		
	end
end

function ENT:PhysicsSimulate( phys, deltatime )
	if IsValid(self.BasePos) then
		phys:Wake()
	 	local pos = self.BasePos.Parts[self:GetGunSlot()].Pos(self, self.BasePos)
		self.ShadowParams.secondstoarrive = 0.01 
		self.ShadowParams.pos = self.BasePos:GetPos() + pos 
		self.ShadowParams.angle =self.BasePos.Parts[self:GetGunSlot()].Angle+self.Offest.Angle+Angle(0,0,0) + self.BasePos:GetAngles()
		self.ShadowParams.maxangular = 5000
		self.ShadowParams.maxangulardamp = 10000
		self.ShadowParams.maxspeed = 1000000 
		self.ShadowParams.maxspeeddamp = 10000
		self.ShadowParams.dampfactor = 0.8
		self.ShadowParams.teleportdistance = 200
		self.ShadowParams.deltatime = deltatime
	 
		phys:ComputeShadowControl(self.ShadowParams)

	end
end