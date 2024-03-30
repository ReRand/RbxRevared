-- events
local clientEv = script.Parent.PingPong.Client;
local serverEv = script.Parent.PingPong.Server;
local referServerEv = script.Parent.PingPong.ReferServer;


local GlobalSide = require(script.Parent.Parent.Parent.Parent.Parent);


function dmgInit(victim, amount)
	local victimHuman = victim:WaitForChild("Humanoid");

    local old = victimHuman.Health
    
	if (victimHuman.Health - amount < 0) then
        amount = amount - math.abs((victimHuman.Health - amount))
    end
    
	victimHuman.Health -= amount;
	local new = victimHuman.Health

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
	dmgInit(victim, amount);		
end)


referServerEv.Event:Connect(dmgInit);
