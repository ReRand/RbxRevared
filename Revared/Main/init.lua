--[[
	== Revared: ReRand Game ToolKit ==
	Created by Paige Sheffield

	https://gitub.com/paishee/RbxRevared
]]


local Revared = {
	Modules = {},
	Experiments = {}
};

local modules = script.Modules;
local experiments = script.Experiments;
local functions = script.Functions;


for _, mod in pairs(modules:GetChildren()) do
    if mod:IsA("ModuleScript") then

		local module = require(mod);
		
        Revared[mod.Name] = module;
		Revared.Modules[mod.Name] = module;
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
