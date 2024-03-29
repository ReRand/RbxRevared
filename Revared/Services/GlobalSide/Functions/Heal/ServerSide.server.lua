-- events
local clientEv = script.Parent.PingPong.Client;
local serverEv = script.Parent.PingPong.Server;
local referServerEv = script.Parent.PingPong.ReferServer;


local GlobalSide = require(script.Parent.Parent.Parent.Parent);


function healInit(victim, amount)
	local victimHuman = victim:WaitForChild("Humanoid");

    local old = victimHuman.Health
    
	if (victimHuman.Health + amount >= victimHuman.MaxHealth) then
        amount = (victimHuman.MaxHealth - (VictimHuman.Health + amount))
    end;
    
    
	victimHuman.Health += amount;
    GlobalSide.Healed.Server:Fire(victim, victimHuman.Health, old);
	clientEv:FireAllClients(victim, victimHuman.Health, old);
end


serverEv:Connect(function(player, victim, amount)
	healInit(victim, amount);		
end)


referServerEv.Event:Connect(healInit);
