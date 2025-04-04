--!optimize 2
--!nonstrict
--!native

local Revared = require(game.ReplicatedStorage.Modules.Revared)
local Nodes = require(Revared.Nodes)

Revared.Root = Nodes.Root.New()

local GetRoot = Revared.Events:FindFirstChild("GetRoot") :: RemoteFunction

GetRoot.OnServerInvoke = function()
    return Revared.Root
end

Revared.Ready = true