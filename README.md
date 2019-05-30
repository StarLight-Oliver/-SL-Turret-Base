# [SL] Turret Base


local ent = ents.Create("base_sl_gun")
ent:SetPos(ply:GetEyeTrace().HitPos+ Vector(0,0, 20))
ent:SetAngles(ply:GetAngles())				
ent:SetTurretType(GetTurret("Basic Turret"))
ent:Spawn()
ent:Activate()



local ent = ents.Create("base_sl_turret")
ent:SetPos(ply:GetEyeTrace().HitPos + Vector(0,0, 100))
ent:SetAngles(ply:GetAngles())
ent:Spawn()
ent:Activate()
