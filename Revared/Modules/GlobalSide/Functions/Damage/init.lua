-- events

local rep = game.ReplicatedStorage;
local events = rep.GameEvents.GlobalSide.Damage;


local clientEv = events.Client;
local serverEv = events.Server;
local referServerEv = events.Server;


-- run context
local RunService = game:GetService("RunService");

local client = RunService:IsClient();
local server = RunService:IsServer();


-- stuff
return (function(GlobalSide)

        
	function GlobalSide:Damage(victim, amount)
		if victim:IsA("Humanoid") then victim = victim.Parent;
		elseif victim:IsA("Player") then victim = victim.Character or victim.CharacterAdded:Wait(); end
			
	    if server then
            referServerEv:Fire(victim, amount);
        elseif client then
            serverEv:FireServer(victim, amount);
        end
	end

        
end)
