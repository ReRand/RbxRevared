--!optimize 2
--!nonstrict
--!native

local Revared = require(game.ReplicatedStorage.Modules.Revared)
local Nodes = require(Revared.Nodes)

	
local entities = Instance.new("Folder")
entities.Name = "Entities"
entities.Parent = workspace

game.Players.PlayerAdded:Connect(function(player)
	local entity = Nodes.Entity.New(Nodes.EntityInfo.New({
		Player = player
	}))

	Revared.Root.Entities.Add(`player_{player.UserId}`, entity)
end)