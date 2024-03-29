-- events
local clientEv = script.Parent.PingPong.Client;
local serverEv = script.Parent.PingPong.Server;
local referServerEv = script.Parent.PingPong.ReferServer;


local GlobalSide = require(script.Parent.Parent.Parent.Parent);


function healInit(victim, amount)
	local victimHuman = victim:WaitForChild("Humanoid");

    local old = victimHuman.Health
    
	if (victimHuman.Health + amount >= victimHuman.MaxHealth) then
        amount = (victimHuman.MaxHealth - (victimHuman.Health + amount))
    end;
    
    
	victimHuman.Health += amount;

	local res = {
			Vicitm = victim, 
			Amount = amount,
			NewHealth = new,
			OldHealth = old
	};
	
    GlobalSide.Healed.Server:Fire(res);
	clientEv:FireAllClients(victim, victimHuman.Health, old);
end


serverEv:Connect(function(player, victim, amount)
	healInit(victim, amount);		
end)


referServerEv.Event:Connect(healInit);
