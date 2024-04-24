return (function(Dict)

    function Dict:GetEntry(keyOrIndex)
      if dict.__dictdata[keyOrIndex] then
        return dict.__dictdata[keyOrIndex];
      else
        for i, entry in ipairs(dict.__dictdata) do
          if entry.Key == keyOrIndex then
            return entry;
          end
        end
    end
    
  end)
