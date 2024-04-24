return (function(Dict)

    function Dict:LastKey(offset)
      if not offset then offset = 0; end
      return self[self.Length-offset].Key;
    end
    
  end)
