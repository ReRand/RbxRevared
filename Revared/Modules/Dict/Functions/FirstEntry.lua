return (function(Dict)

    function Dict:FirstEntry(offset)
      if not offset then offset = 0; end
      return self[1+offset];
    end
    
  end)
