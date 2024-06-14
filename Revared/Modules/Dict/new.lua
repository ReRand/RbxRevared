local Revared = _G.Revared;
local Signal = Revared:GetModule("Signal");


return (function(Dict)

    function Dict.new(...)


		Dict.__index = Dict;


    	local self = setmetatable({

            -- table where everything is stored
            __dictdata = {},
            __args = {...},

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
		
		
		local me = self;
    

		-- imported __ functions
		require(Dict.__.index)(self);
		require(Dict.__.newindex)(self);
		require(Dict.__.tonumber)(self);
		require(Dict.__.tostring)(self);
		

    	return self
    end

        
end)
