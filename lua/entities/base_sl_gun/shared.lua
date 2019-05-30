ENT.Type 			= "anim"
ENT.Base 			= "base_anim"

ENT.Category		= "Star Wars asdasd Emplacements"
ENT.PrintName 		= "Base Gun"
ENT.Author			= "Venator"
ENT.Spawnable		= true
ENT.AdminSpawnable	= false
ENT.Constructor = true

ENT.Accuracy = 0.009
ENT.ShootNumber = 1
ENT.Damage = 85
ENT.Cooldown = 1

ENT.Recoil = 10

function ENT:SetupDataTables()
	self:NetworkVar("Float", 0, "FakeHealth")
	self:NetworkVar("Int", 0, "GunSlot")

	self:NetworkVar("Entity", 0, "Shooter")

	if SERVER then
		self:SetFakeHealth(100)
	end
end

function ENT:Use(activator,caller)
	-- Put a check here to see if there are any guns left on the base of the gun

	if IsValid(self.BasePos) then

		if IsValid(self:GetShooter()) and self:GetShooter() == activator then 
			self:SetShooter(nil)
			activator:SetTurret(false)
			return
		end

		self:SetShooter(activator)
		activator:SetTurret(true)

	else

		self:Remove() -- Pickup the turret
	end
end

local angdif = math.AngleDifference

function AngleLockStuff(a, b, l)
	c = a
	dif = angdif(a, b)
	if math.abs(dif) > l then
		if math.abs(dif) != dif then
			a = b - l
		else
			a = b + l
		end
	end
	return a
end

function ENT:GetShootPos()
	local shootPos=self:GetShooter():GetShootPos()
	local playerTrace=util.GetPlayerTrace( self:GetShooter() )
	playerTrace.filter={self:GetShooter(),self,self.BasePos}

	local shootTrace=util.TraceLine(playerTrace)
	return shootTrace.HitPos
end

function ENT:SetTurretType(tbl)
	self.Cooldown = tbl.Cooldown || self.Cooldown
	self.Recoil = tbl.Recoil || self.Recoil
	self.Damage = tbl.Damage || self.Damage
	self.Accuarcy = tbl.Accuarcy || self.Accuarcy
	self.ShootSound = tbl.ShootSound || self.ShootSound
	self.GunShoot = tbl.GunShoot -- no need to expect shit
	self.ShootNumber = tbl.ShootNumber || self.ShootNumber
	self.Offest = tbl.Offest || self.Offest
	self:SetModel(tbl.Model || self:GetModel())

	self:SetFakeHealth(tbl.Health || self:GetFakeHealth())
end


function ENT:Think()
	if SERVER then
		if IsValid(self:GetShooter()) then
			if self:GetPos():Distance(self:GetShooter():GetPos()) > 100 then 

				self:GetShooter():SetTurret(false)
				self:SetShooter(nil)
				return
			end
			if !IsValid(self.BasePos) then
				self:GetShooter():SetTurret(false)
				self:SetShooter(nil)
				return
			end
			local ply = self:GetShooter()

			local ang = self:GetShooter():EyeAngles() - self.BasePos:GetAngles()
			local lock = self.BasePos.Parts[self:GetGunSlot()].RotationLock
			local ang2 = self.BasePos:GetAngles() + self.BasePos.Parts[self:GetGunSlot()].Angle
			
			local pos = self:GetShootPos()

			local offsetAng=(self:GetPos()-pos):GetNormal()
				local offsetAngNew=offsetAng:Angle() - self.BasePos:GetAngles()


				offsetAngNew:RotateAroundAxis(offsetAngNew:Up(),-90)
				self.Offest.Angle=offsetAngNew		


			if ply:KeyDown(IN_BULLRUSH) then
				self:DoShot()
			end

			if ply:KeyDown(IN_USE) then

				if ply:GetEyeTrace().Entity != self then 
					
					local en = self.BasePos
					self.BasePos = nil
					local slot = self:GetGunSlot()
					self:SetGunSlot(-1)
					en.GunParts[slot] = nil
			
					self.collide:Remove()
				end
			end

		end
	end
end	




function ENT:DoShot()
	
	
	if (self.LastShot ||  0 ) <CurTime() then
		if self.GunShoot then
			self.GunShoot()
		else
			local effectPosAng=self:GetAttachment(self.MuzzleAttachment)
			local vPoint = effectPosAng.Pos
			local effectdata = EffectData()
			effectdata:SetStart( vPoint )
			effectdata:SetOrigin( vPoint )
			effectdata:SetAngles(effectPosAng.Ang + Angle(0,-90,0))
			effectdata:SetEntity(self)
			effectdata:SetScale( 2 )
			util.Effect( "effect_sw_laser_red", effectdata )
			
			self:EmitSound(self.ShotSound,50,100)			
		
			self:FireBullets({
				Num=self.ShootNumber,
				Src=effectPosAng.Pos+effectPosAng.Ang:Up()*10,
				Dir=effectPosAng.Ang:Up()*1,
				Spread=Vector(self.Accuracy,self.Accuracy,0),
				Tracer=0,
				Force=2,
				Damage=self.Damage,
				Attacker=self:GetShooter(),
				Callback=function(attacker,trace,dmginfo) 
					--if CLIENT then
						local tracerEffect=EffectData()
						tracerEffect:SetStart(effectPosAng.Pos)
						tracerEffect:SetOrigin(trace.HitPos)
						tracerEffect:SetScale(6000)
						util.Effect("effect_sw_laser_red",tracerEffect)
						if(!trace.HitSky)then
						local effectdata = EffectData()
						effectdata:SetOrigin(trace.HitPos)
						effectdata:SetScale(2)
						effectdata:SetRadius(trace.MatType)
						effectdata:SetNormal(trace.HitNormal)
						util.Effect("effect_sw_laser_red",effectdata)
						end
					--end
					
					end

			})
			local ply = self:GetShooter()
			util.ScreenShake( self:GetPos(), self.Recoil/2, self.Recoil/2, 0.5, 1024 )
			--ply:ViewPunch( Angle( math.Rand(-1,-051) * self.Recoil, math.Rand(-0.1,0.1) *self.Recoil, 0 ) )
		
					local eyeang = ply:EyeAngles()
		eyeang.pitch = eyeang.pitch - (self.Recoil/4)
		ply:SetEyeAngles( eyeang )

		end
	

		self:GetPhysicsObject():ApplyForceCenter( self:GetRight()*-100000 )
		
		self.LastShot=CurTime() + self.Cooldown
	end
	
end
