script.Parent.Events.RespawnServer.OnServerEvent:Connect(function(player)
	if workspace:FindFirstChild(player.Name) then
		workspace[player.Name]:Destroy();	
	end

	player:LoadCharacter();
	
	-- script.Parent.Server:FireClient(player);
end)


script.Parent.Events.RespawnWHDServer.OnServerEvent:Connect(function(player, desc)
	if workspace:FindFirstChild(player.Name) then
		workspace[player.Name]:Destroy();	
	end

	player:LoadCharacterWithHumanoidDescription(desc);

	-- script.Parent.Server:FireClient(player);
end)
