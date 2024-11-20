-- events

local rep = game.ReplicatedStorage;
local events = rep.GameEvents.GlobalSide.Damage;


local clientEv = events.Client;
local finalEv = events.Finally;
local Revared = require(rep.Modules.Revared)
local GlobalSide = Revared:Require("GlobalSide");


local player = game.Players.LocalPlayer;


function dmgInit(victim, amount, new, old)
	local victimHuman = victim:WaitForChild("Humanoid");
    
	victimHuman.Health = new;

	local res = {
			Vicitm = victim, 
			Amount = amount,
			NewHealth = new,
			OldHealth = old
	};
	
    GlobalSide.Damaged.Client:Fire(player, res);
    
	GlobalSide.Damaged.Finally:Fire(res);
	finalEv:FireServer(res);
end


clientEv:Connect(dmgInit);
