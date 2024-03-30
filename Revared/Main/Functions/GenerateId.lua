local function split(str, sep)
    if sep == nil then sep = "%s" end
    local spl = {};

    for s in string.gmatch(str, "([^"..sep.."]+)") do
        table.insert(spl, s);
    end

    return spl;
end


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
    
        for i=1, length do
            id[i] = characters[math.random(1, #characters)];
        end

		return tostring(table.concat(id));
    end

    
end)
