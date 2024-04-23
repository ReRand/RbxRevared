local Revared = _G.Revared;
local Signal = Revared:GetModule("Signal");


return (function(Entry, Dict)

    function Entry.new(dict, key, index, value, type)
    	local self = setmetatable( {
            Key = key,
            Index = nil,
            Value = value,
            Type = type,
            
            Changed = Signal.new(),
            Destroyed = Signal.new(),
    
            Parent = dict
        }, Dict );
    
    	return self;
    end

        
end)
