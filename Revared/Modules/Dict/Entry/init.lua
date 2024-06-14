local Entry = {}


local functions = script.Functions;
local main = _G.Revared;


function Entry.init(Dict)
  for _, f in ipairs(functions:GetChildren()) do
  	require(f)(Entry, Dict);
  end
end


require(script.new)(Entry, Dict)


return Entry;
