local Revared = _G.Revared;
local Signal = Revared:GetModule("Signal");

function tableid(o)
    return tostring(o):sub(type(o):len() + 3)
end

return (function(Entry, Dict)

    function Entry.new(dict, key, value, type)
    	local self = setmetatable( {
            Key = key,
            Index = nil,
            Value = value,
            Type = type,
            Id = nil,
            
            Changed = Signal.new(),
            Destroyed = Signal.new(),
    
            Parent = dict
        }, Dict );

            
        self.Id = tableid(self);

            
        Entry.__index = function(table, key)
            if key == "Index" then
                for i, entry in ipairs(table.Parent.__dictdata) do
                    if entry.Id == table.Id then
                        return i;
                    end
                end
                    
            elseif rawget(table, ki) then
                return table[ki];
                    
            else
                return nil;
            end    
        end

            
    	return self;
    end

        
end)
