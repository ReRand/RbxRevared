local Dict = {
	
	__types = {
		Uni = 1,
		Pair = 2
	}

}

Dict.__index = Dict


local functions = script.Functions;
local main = _G.Revared;


for _, f in ipairs(functions:GetChildren()) do
	require(f)(Dict);
end


return Dict;
