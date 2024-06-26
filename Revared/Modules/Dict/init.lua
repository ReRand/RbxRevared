local Dict = {

	Entry = nil,
	
	Types = {
		Uni = 1,
		Pair = 2
	},
	
	__ = script.__

}


local functions = script.Functions;
local main = _G.Revared;


local Entry = require(script.Entry);
Entry.init(Dict);


Dict.Entry = Entry;


for _, f in ipairs(functions:GetChildren()) do
	require(f)(Dict);
end

require(script.new)(Dict)


return Dict;
