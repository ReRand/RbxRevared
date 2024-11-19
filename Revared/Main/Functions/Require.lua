return (function(Revared)

        
	function Revared:Require(rawModule, ...)
        local module = require(rawModule);
        
        if module["Init"] then
            module:Init(Revared, table.unpack(...));
        end

        return module;
	end

        
end);
