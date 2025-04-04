--!optimize 2
--!nonstrict
--!native

local Revared = require(game.ReplicatedStorage.Modules.Revared)
local Nodes = require(Revared.Nodes)

repeat task.wait() until Revared.GetRoot()

Revared.Ready = true