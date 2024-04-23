local Revared = _G.Revared;
local Signal = Revared:GetModule("Signal");


return (function(Dict)

    function Dict.new(...)


        Dict.__index = Dict;


    	local self = setmetatable({

            -- table where everything is stored
            __dictdata = {},

            -- events
            Changed = Signal.new(),
                    
            
            Length = nil

        }, Dict);


        for _, tbl in ipairs({...}) do

            local i = 1;

            for ki, v in pairs(tbl) do

                self:Set(i, ki, v);

                i = i + 1;
            end
        end
    

        -- when something is gotten
        Dict.__index = function(table, ki)

            local length = 0;
            for _, __ in pairs(table.__dictdata) do length = length + 1 end
            
            if ki == "Length" then
                return length;

            else

                -- first loop gets priority checking for key matches
                for i, entry in ipairs(table.__dictdata) do
                    if entry.Key == ki then
                        return entry.Value;
                    end
                end

                -- second loop checks for index matches
                for i, entry in ipairs(table.__dictdata) do
                    if entry.Index == ki then
                        return entry.Value;
                    end
                end

                -- if it can't find either it just returns from the table itself or nil
                if rawget(table, ki) then
                    return table[ki];
                  else
                    return nil;
                end
            end
        end;


        -- when something is altered
        Dict.__newindex = function(table, ki, value)
            -- first loop gets priority checking for key matches
            for i, entry in ipairs(table.__dictdata) do
                if entry.Key == ki then
                    entry.Value = value;
                end
            end

            -- second loop checks for index matches
            for i, entry in ipairs(table.__dictdata) do
                if entry.Index == ki then
                    entry.Value = value;
                end
            end

            -- if it can't find either it just sets in the table itself
            if rawget(table, ki) then
                table[ki] = value;
              else
                
            end
        end;


    	return self
    end

        
end)
