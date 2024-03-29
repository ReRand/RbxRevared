-- events
local clientEv = script.PingPong.Client;
local serverEv = script.PingPong.Server;
local referServerEv = script.PingPong.ReferServer;


-- run context
local RunService = game:GetService("RunService");

local client = RunService:IsClient();
local server = RunService:IsServer();


-- stuff
return (function(GlobalSide)

        
	function GlobalSide:Heal(victim, amount)
	    if server then
            referServerEv:Fire(victim, amount);
        elseif client then
            serverEv:FireServer(victim, amount);
        end
	end

        
end)
