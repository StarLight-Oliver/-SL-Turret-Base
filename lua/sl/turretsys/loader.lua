

--[[
	If you are like me, you might be wondering why I have made this addon in "gamemode" format.
	The resoning behind this is that I don't want people to reupload my core files if they want to add new ammo, guns or bases.	
]]--
SL = SL || {}
SL.Turret = SL.Turret || {}

function SL.Turret:AddFolder(DIR)
	local Dir 		= "sl/turretsys/"
	local GAMEFIL 	= file.Find(Dir..DIR.."/*.lua","LUA")
	
	for k,v in pairs( GAMEFIL ) do
		if (SERVER) then AddCSLuaFile(Dir..DIR.."/"..v) end
		include(Dir..DIR.."/"..v)
	end
end

SL.Turret.Guns = SL.Turret.Guns || {}

function AddTurretType(tbl)
	SL.Turret.Guns[tbl.Name] = tbl
	print("Registering Turret Gun " .. tbl.Name)
end

function GetTurret(name)
	return SL.Turret.Guns[name] || {}
end


SL.Turret:AddFolder("guns") 

