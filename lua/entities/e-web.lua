if SERVER then
	AddCSLuaFile()
end
ENT.Type 			= "anim"
ENT.Base 			= "base_sl_turret"

ENT.Category		= "SL"
ENT.PrintName 		= "E-Web Blaster Base"
ENT.Author			= "Star"
ENT.Spawnable		= true
ENT.AdminSpawnable	= false
ENT.Constructor = true
ENT.Model = "models/sw_battlefront/props/e-web_tripod/e-web_tripod.mdl"

ENT.Parts = {
	[1] = {
		Pos = function(self, them)
			return them:GetAngles():Up() * 15 + them:GetAngles():Forward() * 15 - them:GetAngles():Right() * 2
		end,
		Angle = Angle(0,0,0), -- This is the offest angle of the person
		RotationLock = -1,
	},
} 
