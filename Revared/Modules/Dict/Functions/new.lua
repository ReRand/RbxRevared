local Revared = _G.Revared;
local Signal = Revared:GetModule("Signal");


return (function(Dict)

    function Dict.new(...)


    	local self = setmetatable({

            -- table where everything is stored
            __dictdata = {},

            -- events
            --[[Changed = Signal.new(),
            Destroyed = Signal.new(),
            Created = Signal.new(),

            -- this is mostly for updating meta and dict synchronously
            MetaChange = Signal.new(),
            DictChange = Signal.new(),]]
            
            Length = nil

        }, Dict);


        for _, tbl in ipairs({...}) do

            local i = 1;

            for ki, v in pairs(tbl) do

                local entry = nil;
                local vi = 0;


                -- indexed uni
                if type(ki) == "number" and type(v) ~= "table" then
                    entry = Dict.Object.new(self, i, i, v, Dict.Types.Uni);


                -- indexed pair
                elseif type(ki) == "number" and type(v) == "table" then
                    for _, __ in pairs(v) do vi = vi + 1 end

                    if vi == 1 then
                        for pk, pv in pairs(v) do
                            entry = Dict.Object.new(self, pk, i, pv, Dict.Types.Pair);
                        end
                    end
                

                -- unindexed pair 
                elseif type(ki) ~= "number" and type(v) ~= "table" then
                    entry  = Dict.Object.new(self, ki, i, v, Dict.Types.Pair);
                end


                self.__dictdata[entry.Index] = entry;

                i = i + 1;
            end
        end
    

        -- when something is gotten
        Dict.__index = function(table, ki)

            local length = 0;
            for _, __ in pairs(table.__dictdata) do length = length + 1 end
            
            if key == "Length" then
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

                -- if it can't find either it just returns from the table itself
                return self[ki];
            end
        end;


        --[[Dict.__newindex = function(table, key, value)
            
        end;]]


    	return self
    end

        
end)
