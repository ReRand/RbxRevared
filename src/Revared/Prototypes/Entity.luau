--!optimize 2
--!nonstrict
--!native


local Nodes = require(script.Parent.Parent.Nodes)
local RunService = game:GetService("RunService")


function Nodes.Entity.New(info : Nodes._EntityInfo?) : Nodes._Entity?
	if RunService:IsClient() then return end
	info = info or Nodes.EntityInfo.New()

	local self = {
		StarterCharacter = info.StarterCharacter,

		Health = info.Health or 100,
		Gravity = info.Gravity or 9.8,
		
		Standing = true,
		Jumping = false,

		Inventory = info.Inventory or Nodes.Collection.New(),

		Killed = Nodes.Signal.New()
	}

	return Nodes.Init(self, Nodes.Entity) :: Nodes._Entity
end


function Nodes.Entity.Prototype:Spawn(character: Model?)

end


function Nodes.Entity.Prototype:Kill(reason)
	if RunService:IsServer() then
		print(reason)
	end
end


return Nodes.Entity :: Nodes._EntityStatic
