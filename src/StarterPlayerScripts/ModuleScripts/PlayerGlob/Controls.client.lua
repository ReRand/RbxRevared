repeat task.wait() until game:IsLoaded();

local player = game.Players.LocalPlayer;

repeat task.wait() until player:WaitForChild("valuesLoaded").Value

local PlayerModule = require(player.PlayerScripts:WaitForChild('PlayerModule'))
local controls = PlayerModule:GetControls()

local Revared = require(game.ReplicatedStorage.Modules.Revared);
local controlClient = Revared.Events.PlayerGlob.ControlClient;
local controlServer = Revared.Events.PlayerGlob.ControlServer;

function control(b)
	if b == true then
		controls:Enable()
	else
		controls:Disable()
	end
end

controlServer.OnClientEvent:Connect(control);
controlClient.Event:Connect(control)