local PlayerGlob = {
	PlayerSounds = require(script.PlayerSounds),
	Events = game.ReplicatedStorage.GameEvents.Modules.PlayerGlob
};

local rs = game:GetService("RunService");


function PlayerGlob:Respawn(player)
	if rs:IsClient() then
		PlayerGlob.Events.RespawnServer:FireServer();
	else
		if workspace:FindFirstChild(player.Name) then
			workspace[player.Name]:Destroy();	
		end

		player:LoadCharacter();
	end
	
	return player.Character or player.CharacterAdded:Wait();
end


function PlayerGlob:RespawnWithDescription(player, desc)
	if rs:IsClient() then
		PlayerGlob.Events.RespawnWHDServer:FireServer(desc);
	else
		if workspace:FindFirstChild(player.Name) then
			workspace[player.Name]:Destroy();	
		end

		player:LoadCharacterWithHumanoidDescription(desc);
	end

	return player.Character or player.CharacterAdded:Wait();
end


return PlayerGlob
