-- events
local rep = game.ReplicatedStorage
local events = rep.GameEvents.GlobalSide.Heal;

local clientEv = events.Client;
local serverEv = events.Server;
local referServerEv = events.ReferServer;
local finalEv = events.Finally;


local Revared = require(rep.Modules.Revared)
local GlobalSide = Revared:Require("GlobalSide");


function healInit(victim, amount)
	local victimHuman = victim:WaitForChild("Humanoid");

    local old = victimHuman.Health
    
	if (victimHuman.Health + amount > victimHuman.MaxHealth) then
		amount -= ((victimHuman.Health + amount) - victimHuman.MaxHealth)
    end;
    
    
	victimHuman.Health += amount;
	local new = victimHuman.Health;

	local res = {
			Vicitm = victim, 
			Amount = amount,
			NewHealth = new,
			OldHealth = old
	};
	
    GlobalSide.Healed.Server:Fire(res);
	clientEv:FireAllClients(victim, amount, new, old);
end


serverEv.OnServerEvent:Connect(function(player, victim, amount)
	healInit(victim, amount);		
end)


finalEv.OnServerEvent:Connect(function(res)
	GlobalSide.Damaged.Finally:Fire(res);	
end)


referServerEv.Event:Connect(healInit);
