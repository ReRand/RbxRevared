local PingPong = {};


local functions = script.Functions;


for _, f in ipairs(functions:GetChildren()) do
	require(f)(PingPong);
end


return PingPong;
