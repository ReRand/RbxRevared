--!optimize 2
--!nonstrict
--!native

local Nodes = require(script.Parent.Parent.Nodes)


function Nodes.Root.New() : Nodes._Root
	local entities = Nodes.Collection.New() :: Nodes._Collection<string, Nodes._Entity>
	
    local self = {
        Entities = entities
    } :: Nodes._Root

	return Nodes.Init(self, Nodes.Root) :: Nodes._Root
end


return Nodes.Root :: Nodes._RootStatic