--[[
	== Revared: ReRand Game ToolKit ==
	Created by Paige "paishee" Sheffield

	https://gitub.com/ReRand/RbxRevared
]]


local Revared = {
	Modules = {},
	Experiments = {}
};



local modules = script:FindFirstChild("Modules");
local experiments = script:FindFirstChild("Experiments");
local functions = script:FindFirstChild("Functions");



if modules then
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
end



if experiments then
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



if functions then
	for _, f in ipairs(functions:GetChildren()) do
		require(f)(Revared);
	end
end



return Revared;
