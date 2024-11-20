local Revared = _G.Revared;
local Signal = Revared:Require('Signal');

local PlayerGlob = {
	PlayerSounds = require(script.PlayerSounds),
	Events = Revared.Events.PlayerGlob,

	Healed = {
		Server = Signal.new(),
		Client = Signal.new(),
		Finally = Signal.new()
	},

	Damaged = {
		Server = Signal.new(),
		Client = Signal.new(),
		Finally = Signal.new()
	}
};


local functions = script.Methods;


for _, f in ipairs(functions:GetChildren()) do
	require(f)(PlayerGlob);
end


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
