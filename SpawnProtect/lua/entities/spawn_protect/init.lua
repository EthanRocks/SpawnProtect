AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:Initialize()		
	self.Entity:SetAngles( Angle(0,0,0) )
	self.Entity:SetModel( "models/hunter/blocks/cube8x8x8.mdl" )
		
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_NONE)
	self.Entity:SetRenderMode(RENDERMODE_TRANSALPHA)
	
	local phys = self.Entity:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
	end
	
	self.Entity:SetColor(Color(200,0,0,50))
	self.Entity:DrawShadow( false )
	self.Entity:EnableCustomCollisions( true )
	
end

function ENT:OnBoxSizeChanged( varname, oldvalue, newvalue )
	
	local mins = self.Entity:OBBMins()*newvalue
	local maxs = self.Entity:OBBMaxs()*newvalue

	self.v1 = mins + Vector(100,100,100) + self.Entity:GetPos()
	self.v2 = maxs - Vector(100,100,100) + self.Entity:GetPos()
	
	self.Entity:PhysicsInitBox(mins,maxs)
	self.Entity:SetCollisionBounds(mins,maxs)
	self.Entity:SetMoveType(MOVETYPE_NONE)
	
	local phys = self.Entity:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
	end
	
end

function ENT:Think()
	for k, v in pairs(ents.FindInBox(self.v1,self.v2)) do
		if v:GetPhysicsObject():IsValid() and not (v == self.Entity or v:IsPlayer() or v:IsWeapon() or v:IsWorld()) then
			v:Remove()
		end
	end
end

local function SpawnProtectCreate(vec,vec2)
	

	local prop = ents.Create( "spawn_protect" ) --380
	
	local pos = (vec+vec2)/2
	local scale = (vec-pos)/189.8
	
	prop:SetPos(pos - Vector(0,0,166.075*math.abs(scale.z)))
	
	prop:Spawn()
	prop:SetBoxSize(Vector(math.abs(scale.x), math.abs(scale.y), math.abs(scale.z)))
	prop:SetPersistent(true)
	
end

local lastv = nil
concommand.Add("spawnprotect",function(ply)
	if not ply:IsSuperAdmin() then return end
	local vec = ply:GetEyeTrace().HitPos
	
	if not lastv then
		lastv = vec
	else
		SpawnProtectCreate(lastv, vec)
		lastv = nil
	end
end)
concommand.Add("spawnprotect_clear", function(ply)
	if not ply:IsSuperAdmin() then return end
	for k, v in pairs(ents.FindByClass("spawn_protect")) do v:Remove() end
end)
