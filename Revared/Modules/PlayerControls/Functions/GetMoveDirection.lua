return (function(PlayerControls)

    function PlayerControls:GetMoveDirection(player)
        if player:IsA("Humanoid") then player = player.Parent;
		elseif player:IsA("Player") then player = player.Character or player.CharacterAdded:Wait(); end

        
    end
        
end)
