--[[
	== Revared: ReRand Game ToolKit ==
	Created by Paige "paishee" Sheffield

	https://gitub.com/ReRand/RbxRevared
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
		
		if module["Init"] then
			module:Init(Revared);
		end
		
        Revared[mod.Name] = module;
		Revared.Modules[mod.Name] = module;
    end
end


for _, exp in pairs(experiments:GetChildren()) do
    if exp:IsA("ModuleScript") then

		local experiment = require(exp);
		
		if experiment["Init"] then
			experiment:Init(Revared);
		end
		
		Revared.Experiments[exp.Name] = experiment;
    end
end


for _, f in ipairs(functions:GetChildren()) do
	require(f)(Revared);
end


_G.Revared = Revared;
return Revared;
