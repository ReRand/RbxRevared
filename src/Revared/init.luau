--!optimize 2
--!nonstrict
--!native

for _, mod: ModuleScript in script:GetDescendants() do
	if mod:IsA("ModuleScript") then
		require(mod)
	end
end


local Revared = {
	Addons = script.Addons,
    Nodes = script.Nodes
}

local Package = require(script.Package)
local Nodes = require(script.Nodes) :: Package._NodePackage


Revared.CreateNode = Nodes.Spawn
Revared.Entities = Nodes.
Revared.Enums = Nodes.Enums


type _Game = Nodes._Node & {

}


return Revared