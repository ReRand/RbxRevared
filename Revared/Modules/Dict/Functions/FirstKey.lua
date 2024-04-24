return (function(Dict)

    function Dict:FirstKey(offset)
      if not offset then offset = 0;
      return self[1+offset].Key;
    end
    
  end)
