return (function(Dict)

    function Dict:Pop(offset)
      return self:Last(offset):Destroy()
    end
    
  end)
