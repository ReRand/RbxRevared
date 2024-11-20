local rs = game:GetService("RunService");


-- stuff
return (function(PlayerGlob)
        
    function PlayerGlob:DisableControls(player)
        if rs:IsClient() then
            PlayerGlob.Events.ClientControl:Fire(false)
        elseif rs:IsClient() then
            PlayerGlob.Events.ServerControl:FireClient(player, false)
        end
    end

end)