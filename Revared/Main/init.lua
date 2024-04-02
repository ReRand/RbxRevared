--[[
	== Revared: ReRand Game ToolKit ==
	Created by Paige "paishee" Sheffield

	https://gitub.com/ReRand/RbxRevared
]]


local Revared = {
	Modules = {}
};


local modules = script.Modules;
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


if script.Experiments.Value then
	local experiments = script.Experiments;
	Revared.Experiments = {}
	
	for _, exp in pairs(experiments:GetChildren()) do
	    if exp:IsA("ModuleScript") then
	
			local experiment = require(exp);
			
			if experiment["Init"] then
				experiment:Init(Revared);
			end
			
			Revared.Experiments[exp.Name] = experiment;
	    end
	end
end


for _, f in ipairs(functions:GetChildren()) do
	require(f)(Revared);
end


_G.Revared = Revared;
return Revared;
