-- events
local clientEv = script.Parent.PingPong.Client;
local GlobalSide = require(script.Parent.Parent.Parent.Parent);


function healInit(victim, amount)
	local victimHuman = victim:WaitForChild("Humanoid");

    local old = victimHuman.Health;
    
	if (victimHuman.Health + amount >= victimHuman.MaxHealth) then
        amount = (victimHuman.MaxHealth - (VictimHuman.Health + amount))
    end;
    
    
	victimHuman.Health += amount;
    GlobalSide.Healed.Client:Fire(victim, victimHuman.Health, old);
    GlobalSide.Healed.Finally:Fire(victim, victimHuman.Health, old);
end


clientEv:Connect(healInit);
