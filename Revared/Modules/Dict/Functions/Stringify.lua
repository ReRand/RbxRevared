function stringify(o, indents, layer)
    if not layer then layer = 0; end
    
    local tab = ""
    
    for i = 1, indents do 
      tab = tab.." ";
    end
    
    for i = 1, layer do
      tab = tab..tab;
    end
    
    print('"'..tab..'"');
    
   if type(o) == 'table' then
      local s = '{\n'
      for k,v in pairs(o) do
         if layer == 0 then
           s = s..stringify(v, indents, layer+1) .. ','
          else
            s = s .. k ..': ' .. stringify(v, indents, layer+1) .. ',\n'
          end
      end
      return s .. '}'
   else
      if type(o) == "string" then return '"'..o..'"';
      else return tostring(o); end
   end
end


return (function(Dict)

  function Dict:Stringify(indents, layer)
    local o = self.StringEntries;
    return stringify(o, indents, layer);
  end
    
  end)
