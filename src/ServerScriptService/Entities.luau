--!optimize 2
--!nonstrict
--!native

local Revared = require(game.ReplicatedStorage.Modules.Revared)
local Nodes = require(game.ReplicatedStorage.Modules.Revared.Nodes)

local entities = Instance.new("Folder")
entities.Parent = workspace

game.Players.PlayerAdded:Connect(function(player)
    local entity = Nodes.Entity.New(Nodes.EntityInfo.New({
        Player = player
    }))
end)