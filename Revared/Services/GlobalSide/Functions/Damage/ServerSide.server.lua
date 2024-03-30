-- events
local clientEv = script.Parent.PingPong.Client;
local serverEv = script.Parent.PingPong.Server;
local referServerEv = script.Parent.PingPong.ReferServer;


local GlobalSide = require(script.Parent.Parent.Parent.Parent);


function dmgInit(victim, amount)
	local victimHuman = victim:WaitForChild("Humanoid");

    local old = victimHuman.Health
    
	if (victimHuman.Health - amount < 0) then
        amount = amount - math.abs(victimHuman.Health - amount))
    end
    
	victimHuman.Health -= amount;

	local res = {
			Vicitm = victim, 
			Amount = amount,
			NewHealth = victimHuman.Health,
			OldHealth = old
	};
	
    GlobalSide.Healed.Server:Fire(res);
	clientEv:FireAllClients(victim, victimHuman.Health, old);
end


serverEv:Connect(function(player, victim, amount)
	dmgInit(victim, amount);		
end)


referServerEv.Event:Connect(dmgInit);