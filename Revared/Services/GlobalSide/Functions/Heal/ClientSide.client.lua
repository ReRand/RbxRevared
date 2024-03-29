-- events
local clientEv = script.Parent.PingPong.Client;
local GlobalSide = require(script.Parent.Parent.Parent.Parent);


local players = game.Players;
local player = players.LocalPlayer;


function healInit(victim, new, old)
	local victimHuman = victim:WaitForChild("Humanoid");
    
    
	victimHuman.Health = new;
    GlobalSide.Healed.Client:Fire(player, victim, new, old);
    GlobalSide.Healed.Finally:Fire(victim, new, old);
end


clientEv:Connect(healInit);
