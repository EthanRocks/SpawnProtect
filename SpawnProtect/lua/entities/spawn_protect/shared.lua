

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT 

ENT.PrintName		= "Spawn protect"
ENT.Author			= "thegrb93"
ENT.Contact			= ""


hook.Add("ShouldCollide","OnlyPlayersSpawnprotect",function(a,b)
	if a:IsPlayer() then
		if b:GetClass()=="spawn_protect" then return false end
	elseif b:IsPlayer() then
		if a:GetClass()=="spawn_protect" then return false end
	end
end)

function ENT:SetupDataTables()
	self:NetworkVar( "Vector", 0, "BoxSize", { KeyName = "boxsize" } )

	if SERVER then
		self:NetworkVarNotify( "BoxSize", self.OnBoxSizeChanged )
	end
	
end

function ENT:TestCollision()
	return
end