local rs = game:GetService("RunService");


-- stuff
return (function(PlayerGlob)
        
    function PlayerGlob:EnableControls(player)
        if rs:IsClient() then
            PlayerGlob.Events.ClientControl:Fire(true)
        elseif rs:IsClient() then
            PlayerGlob.Events.ServerControl:FireClient(player, true)
        end
    end

end)