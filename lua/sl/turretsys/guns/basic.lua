local tbl = {
	Name = "Basic Turret",
	Model = "",
	Cooldown = 1,
	Health = 2,
	Damage = 100,
	Accuarcy = 0.009,
	ShootNumber = 1,
	Recoil = 10,
	ShootSound = "",
	--[[GunShoot = function(self )
	end,]]--
	Offest = {
		Pos = Vector(0,0,0),
		Angle = Angle(0,0,0),
	},
}
AddTurretType(tbl)