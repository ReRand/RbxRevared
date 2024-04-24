return (function(Dict)

  function Dict:Stringify(indents, layer)
  local o = self.StringEntries;
  return stringify(o, indents, layer);
end
    
  end)
