local Revared = {};
local services = script.Services;
local functions = script.Functions


for _, serv in pairs(services:GetChildren()) do
    if serv:IsA("ModuleScript") then
        Revared[serv.Name] = require(serv);
    end
end


for _, f in ipairs(functions:GetChildren()) do
	require(f)(Revared);
end


return Revared;
