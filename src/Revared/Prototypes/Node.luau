--!optimize 2
--!nonstrict
--!native

local Nodes = require(script.Parent.Parent.Nodes)
local RunService = game:GetService("RunService")
local Events = script.Parent.Parent.Events.Node


function Nodes.Node.Prototype:Destroy()
	if (self.Parent and self.index) then self.Parent[self.Index] = nil end
	self.Parent = nil;
	self = nil
end


function Nodes.Node.Prototype:Clone()

end


function Nodes.Node.Prototype:AddChild(name: string, ...): Nodes._Node
	local node = Nodes.Spawn(name, ...)
	self.Children:Add(node)
	return node
end


function Nodes.Node.New() : Nodes._Node
	return Nodes.Init({}, Nodes.Node) :: Nodes._Node
end


function Nodes.Node.Prototype:Replicate() : Nodes._Node?
	if not self.Node:GetConfig().Repilcable then return end
end


function Nodes.Node.Prototype:GetServer(...: string?) : Nodes._Node
	if RunService:IsServer() then
		Events.Message:FireClient()
	end
end

function Nodes.Node.Prototype:GetClient(player: Player, ...: string? ): Nodes._Node
	if RunService:IsServer() then
		
	end
end

return Nodes.Node :: Nodes._NodeStatic