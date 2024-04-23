local Bucket = {
	
	__types = {
		Uni = 1,
		Pair = 2
	}

}

Bucket.__index = Bucket


local functions = script.Functions;
local main = _G.Revared;


for _, f in ipairs(functions:GetChildren()) do
	require(f)(Bucket);
end


return Bucket;
