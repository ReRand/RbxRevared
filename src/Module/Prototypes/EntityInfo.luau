--!optimize 2
--!nonstrict
--!native


local Nodes = require(script.Parent.Parent.Nodes)


function Nodes.EntityInfo.New(info : { [string]: any }?) : Nodes._EntityInfo?
	local info: { [string]: any } = info or {}

	local self = {
	}

	return Nodes.Init(self, Nodes.EntityInfo) :: Nodes._EntityInfo
end


return Nodes.EntityInfo :: Nodes._EntityInfoStatic
