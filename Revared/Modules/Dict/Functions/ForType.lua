return (function(Dict)

    function Dict:ForType(tbl)
        local uni = nil;
      local pair = nil;
      
        for type, f in pairs(tbl)
          if (type(type) == "string" and lower(type) == "uni") or (type(type) == "number" and type == Dict.Types.Uni) then
            uni = f;
      elseif (type(type) == "string" and lower(type) == "pair") or (type(type) == "number" and type == Dict.Types.Pair) then
            pair = f;
      end
    end
      
        for i, entry in ipairs(self.__dictdata) do
            if entry.Type == Dict.Types.Uni and uni then
                uni(entry.Value, i);
            elseif entry.Type == Dict.Types.Pair and pair then
                pair(entry.Key, entry.Value, i);
            end
        end
    end
    
end)
