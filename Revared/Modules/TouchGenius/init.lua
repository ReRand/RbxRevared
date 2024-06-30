local RBXScriptSignal = require(workspace.Modules.Signal);
local Revared = _G.Revared;

local TouchResult = require(script.TouchResult);
local TouchParams = require(script.TouchParams);



local TouchGenius = {
	TouchResult = TouchResult,
	TouchParams = TouchParams,
	
	TouchFilterTypes = {
		Include = Enum.RaycastFilterType.Include,
		Exclude = Enum.RaycastFilterType.Exclude
	}
};

TouchGenius.__index = TouchGenius;



function TouchGenius.new(part: Instance, touchParams: TouchParams)
	if not touchParams then touchParams = TouchParams.new(); end
	
	
	local self = setmetatable({
		
		Part = part,
		TouchParams = touchParams,	
		
		Touched = RBXScriptSignal.new(),
		TouchEnded = RBXScriptSignal.new(),
		
		TouchMaintained = RBXScriptSignal.new(),
		
		MaintainActive = true
		
		
	}, TouchGenius);
	
	
	part.Touched:Connect(function(hit) 
		if not self.TouchParams.RawResults then
			hit = self:CreateTouchResult(hit);
		end
		self.Touched:Fire(hit);
	end);
	
	part.TouchEnded:Connect(function(hit)
		if not self.TouchParams.RawResults then
			hit = self:CreateTouchResult(hit);
		end
		self.TouchEnded:Fire(hit);
	end)
	
	
	if self.TouchParams.Maintain then
		coroutine.wrap(function()
			while task.wait(self.TouchParams.MaintainLoopDelay or 0) do
				if self.MaintainActive then
					for i, p in ipairs(self:GetTouchingParts()) do
						self.TouchMaintained:Fire(p);
					end
				end
			end
		end)();
	end
	
	
	return self;
end



function TouchGenius:IsTouching(part, filter)
	for i, p in ipairs(self:GetTouchingParts(filter)) do
		if p == part then return true, i; end
	end
	return false, -1;
end



function TouchGenius:GetTouchingParts(filter)
	if not filter then filter = self.TouchParams.Filter; end
	local touching = self.Part:GetTouchingParts();
	
	for i_t, t in ipairs(touching) do
		local dir = Revared:GetDirectoryOf(t);
		
		local g = game;
		
		for _, d in pairs(dir) do
			g = g:FindFirstChild(d);
			
			for _, f in pairs(filter) do
				if f == g then
					table.remove(touching, i_t);
				end
			end
		end
	end
	
	if not self.TouchParams.RawResults then
		for i, t in ipairs(touching) do
			touching[i] = self:CreateTouchResult(t);
		end
	end
	
	return touching;
end



function TouchGenius:GetRawTouchingParts()
	return self.Part:GetTouchingParts();
end



function TouchGenius:CreateTouchResult(part)
	return TouchResult.new(self, part);
end


return TouchGenius
