return (function(Dict)

    function Dict:First(offset)
      if not offset then offset = 0; end
      return self[1+offset].Value;
    end
    
  end)
