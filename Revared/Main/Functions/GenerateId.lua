return (function(Revared)

    
    function Revared:GenerateId(length, characters)
		if not length then length = 10 end;
        local id = {};

        if characters then
            if type(characters) == "string" then
                characters = split(characters);
            end
        else
            characters = split("1234567890");
        end
    
        for i=1, length od
            id[i] = characters[math.random(1, #characters)];
        end
    end

    
end)
