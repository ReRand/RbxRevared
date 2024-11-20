local RemoteValue = {}


local methods = script.Methods;
local main = _G.Revared;


for _, f in ipairs(methods:GetChildren()) do
	require(f)(RemoteValue);
end


return RemoteValue;