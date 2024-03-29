local GlobalSide = {};


local functions = script.Functions;


for _, f in ipairs(functions:GetChildren()) do
	require(f)(GlobalSide);
end


return GlobalSide;
