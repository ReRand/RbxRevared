return (function(Dict)

    function Dict:Clone()
        local cloned = Dict.new();
        
            
        for key, entry in pairs(self.__dictdata) do
            cloned.__dictdata[key] = entry:Clone();
        end


        return cloned;
    end
    
end)