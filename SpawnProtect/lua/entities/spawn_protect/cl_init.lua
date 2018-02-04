include('shared.lua')

function ENT:Initialize()
end

function ENT:Draw()

	if self.BoxSize ~= self.Entity:GetBoxSize() then
		self.BoxSize = self.Entity:GetBoxSize()
		
		local mat = Matrix()
		mat:Scale( self.BoxSize )
		self.Entity:EnableMatrix("RenderMultiply",mat)	
		self.Entity:SetRenderBounds( self.Entity:OBBMins()*self.BoxSize, self.Entity:OBBMaxs()*self.BoxSize)
	end

	self.Entity:DrawModel()
end

function ENT:DrawEntityOutline()
end
