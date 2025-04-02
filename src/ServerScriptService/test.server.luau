--!optimize 2
--!nonstrict
--!native

local Revared = require(game.ReplicatedStorage.Modules.Revared)
local Nodes = require(game.ReplicatedStorage.Modules.Revared.Nodes)

local collection = Nodes.Collection.New({
	{ 1, "foo" },
	{ 2, "a" }
}) :: Nodes._Collection<number, string>;


local entity = Nodes.Entity.New(game.Players.LocalPlayer) :: Nodes._Entity

print(collection)
print(entity)
