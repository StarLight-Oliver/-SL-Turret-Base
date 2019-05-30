local plymeta = FindMetaTable("Player")

if SERVER then
	AddCSLuaFile("sl/turretsys/loader.lua")

	
	util.AddNetworkString("sl_turret_toggle")

	function plymeta:SetTurret(bool)
		self:DrawViewModel(!bool)
		self.TurretBlockMode = bol
		net.Start("sl_turret_toggle")
			net.WriteBool(bool)
		net.Send(self)
	end
	
elseif CLIENT then

	net.Receive("sl_turret_toggle", function()
		LocalPlayer().TurretBlockMode = net.ReadBool()
	end)

	hook.Add("CreateMove","sl_block_attack",function(cmd)
		local lp = LocalPlayer()
		if lp.TurretBlockMode and IsValid(lp) then
			if bit.band(cmd:GetButtons(), IN_ATTACK) > 0 then
				cmd:SetButtons(bit.bor(cmd:GetButtons() - IN_ATTACK, IN_BULLRUSH)) -- Takes away in attack and adds bullrush to the number
			elseif  bit.band(cmd:GetButtons(), IN_ATTACK2) > 0 then

			end
		end
	end) 
end

include("sl/turretsys/loader.lua")