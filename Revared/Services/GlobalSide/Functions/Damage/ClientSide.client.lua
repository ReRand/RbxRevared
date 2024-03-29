-- events
local clientEv = script.Parent.PingPong.Client;
local GlobalSide = require(script.Parent.Parent.Parent.Parent);


local player = game.Players.LocalPlayer;


function dmgInit(victim, amount new, old)
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
end


clientEv:Connect(dmgInit);
