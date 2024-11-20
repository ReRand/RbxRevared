local Revared = require(game.ReplicatedStorage.Modules.Revared);
local serverFromClient = Revared.Events.Replicator:WaitForChild("GetServerFromClient");


serverFromClient.OnServerEvent:Connect(function(player, dir, args)
	local inst = game;

	for _, d in ipairs(dir) do
		inst = inst[d];
	end

	for _, a in ipairs(args) do
		inst = inst[a];
	end

	serverFromClient:FireClient(player, player, inst);
	return inst;
end)