--!optimize 2
--!nonstrict
--!native

local Revared = require(game.ReplicatedStorage.Modules.Revared)
local Nodes = require(game.ReplicatedStorage.Modules.Revared.Nodes)

Revared.Root = Nodes.Root.New()

Revared.Events.GetRoot.OnServerInvoke = function()
    return Revared.Root
end