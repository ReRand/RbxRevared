--[[
	== Revared ==
	Created by Paige Sheffield

	https://gitub.com/paishee/Revared
]]


local Revared = {
	Services = {},
	Experiments = {}
};

local services = script.Services;
local experiments = script.Experiments;
local functions = script.Functions;


for _, serv in pairs(services:GetChildren()) do
    if serv:IsA("ModuleScript") then

		local service = require(serv);
		
        Revared[serv.Name] = service;
		Revared.Services[serv.Name] = service;
    end
end


for _, exp in pairs(experiments:GetChildren()) do
    if exp:IsA("ModuleScript") then

		local experiment = require(exp);
		
		Revared.Experiments[experiment.Name] = experiment;
    end
end


for _, f in ipairs(functions:GetChildren()) do
	require(f)(Revared);
end


return Revared;
