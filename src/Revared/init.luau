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
    Nodes = script.Nodes,
	Events = script.Events.Revared
}

local RunService = game:GetService("RunService")
local Package = require(script.Package)
local Nodes = require(script.Nodes) :: Package._NodePackage

function Revared.GetRoot(): Nodes._Root
	return RunService:IsClient() and Events.GetRoot:InvokeServer() or Revared.Root
end

type _Revared = {
	Addons: Folder,
	Nodes: ModuleScript,
	Enums: {},
	Root: Nodes._Root?,
	Events: Folder,

	SpawnNode: <T>(name : string, ...any) -> T,
	GetRoot: () -> Nodes._Root
}

Revared.SpawnNode = Nodes.Spawn
Revared.Enums = Nodes.Enums


return Revared :: _Revared