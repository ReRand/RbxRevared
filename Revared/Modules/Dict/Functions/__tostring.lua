-- https://stackoverflow.com/questions/9168058/how-to-dump-a-table-to-console

function dump(o)
   if type(o) == 'table' then
      local s = '{\n'
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. k ..': ' .. dump(v) .. ','
      end
      return s .. '\n}'
   else
      return tostring(o)
   end
end

return (function(Dict)

  function Dict.__tostring()
      return "Dict ("..tostring(self.Length)..") "..dump(self.__dictdata);
    end
    
  end)
