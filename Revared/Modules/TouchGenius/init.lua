local RBXScriptSignal = require(workspace.Modules.Signal);
local Revared = _G.Revared;

local TouchResult = require(script.TouchResult);



local TouchGenius = {
	TouchResult = TouchResult,
	
	TouchFilterTypes = {
		Include = Enum.RaycastFilterType.Include,
		Exclude = Enum.RaycastFilterType.Exclude
	},
	
	TouchStates = {
		TouchBegin = Enum.UserInputState.Begin,
		TouchEnd = Enum.UserInputState.End,
		TouchMaintain = Enum.UserInputState.Change,
		None = Enum.UserInputState.None
	}
};

TouchGenius.__index = TouchGenius;



local TouchParams = require(script.TouchParams)(TouchGenius);
TouchGenius.TouchParams = TouchParams;



function TouchGenius.new(part: Instance, touchParams: TouchParams)
	if not touchParams then touchParams = TouchParams.new(); end
	
	
	local self = setmetatable({
		
		Part = part,
		TouchParams = touchParams,	
		
		DefaultTouched = RBXScriptSignal.new(),
		DefaultTouchEnded = RBXScriptSignal.new(),
		
		Touched = RBXScriptSignal.new(),
		TouchEnded = RBXScriptSignal.new(),
		
		TouchMaintained = RBXScriptSignal.new(),
		
		MaintainActive = true,
		
		AsyncWaiting = {}
		
		
	}, TouchGenius);
	
	
	
	part.Touched:Connect(function(hit)
		
		local origin = hit
		
		if self:IsFiltered(origin, self.TouchParams.TouchFilter, self.TouchParams.TouchFilterType) then return end;
		
		if not self.TouchParams.RawResults then
			hit = self:CreateTouchResult(origin, TouchGenius.TouchStates.TouchBegin);
			self.DefaultTouched:Fire(hit, origin, TouchGenius.TouchStates.TouchBegin);
		else
			self.DefaultTouched:Fire(origin, TouchGenius.TouchStates.TouchBegin);
		end
		
		
		if not self:IsAsyncWaiting(origin) then
			table.insert(self.AsyncWaiting, origin);
		
		
			self.Touched:Fire(hit, origin, TouchGenius.TouchStates.TouchBegin);
			
			
			coroutine.wrap(function()
				
				repeat task.wait(self.TouchParams.MaintainLoopDelay or 0) until not self:IsTouching(origin)
				local _, i = self:IsAsyncWaiting(origin);
				
				table.remove(self.AsyncWaiting, i);
				
				if not self.TouchParams.RawResults then
					hit = self:CreateTouchResult(origin, TouchGenius.TouchStates.TouchEnd);
					self.TouchEnded:Fire(hit, origin, TouchGenius.TouchStates.TouchEnd);
				else
					self.TouchEnded:Fire(origin, TouchGenius.TouchStates.TouchEnd);
				end
				
			end)()
		end
	end);
	
	
	
	part.TouchEnded:Connect(function(hit)
		
		local origin = hit
		
		if self:IsFiltered(origin, self.TouchParams.TouchFilter, self.TouchParams.TouchFilterType) then return end;
		
		if not self.TouchParams.RawResults then
			hit = self:CreateTouchResult(origin, TouchGenius.TouchStates.TouchEnd);
			self.DefaultTouched:Fire(hit, origin, TouchGenius.TouchStates.TouchEnd);
		else
			self.DefaultTouched:Fire(origin, TouchGenius.TouchStates.TouchEnd);
		end
	end)
	
	
	
	if self.TouchParams.Maintain then
		coroutine.wrap(function()
			while task.wait(self.TouchParams.MaintainLoopDelay or 0) do
				if self.MaintainActive then
					for i, p in ipairs(self:GetTouchingParts()) do
						
						if self.TouchParams.RawResults then
							self.TouchMaintained:Fire(p, TouchGenius.TouchStates.TouchMaintain);
						else
							self.TouchMaintained:Fire(p, p.Instance, TouchGenius.TouchStates.TouchMaintain);
						end
					end
				end
			end
		end)();
	end
	
	
	return self;
end



function TouchGenius:IsTouching(part, filter)
	for i, p in ipairs(self:GetInstanceTouchingParts(filter)) do
		if p == part then return true, i; end
	end
	return false, -1;
end



function TouchGenius:IsAsyncWaiting(part)
	for i, p in ipairs(self.AsyncWaiting) do
		if p == part then return true, i; end
	end
	return false, -1;
end



function TouchGenius:GetTouchingParts(filter, filterType)
	local touching = self:GetInstanceTouchingParts(filter, filterType);
	
	if not self.TouchParams.RawResults then
		for i, t in ipairs(touching) do
			touching[i] = self:CreateTouchResult(t, TouchGenius.TouchStates.TouchMaintain);
		end
	end
	
	return touching;
end



function TouchGenius:GetInstanceTouchingParts(filter, filterType)
	if not filter then filter = self.TouchParams.MaintainFilter; end
	if not filterType then filterType = self.TouchParams.MaintainFilterType end
	local touching = self.Part:GetTouchingParts();


	for i_t, t in ipairs(touching) do
		if self:IsFiltered(t, filter, filterType) then
			table.remove(touching, i_t);
		end
	end
	

	return touching;
end



function TouchGenius:GetRawTouchingParts()
	return self.Part:GetTouchingParts();
end



function TouchGenius:CreateTouchResult(part, state)
	return TouchResult.new(self, part, state);
end



function TouchGenius:IsFiltered(part, filter, filterType)
	local dir = Revared:GetDirectoryOf(part);
	local g = game;

	for _, d in pairs(dir) do
		g = g:FindFirstChild(d);

		for _, f in pairs(filter) do
			if f == g and filterType == TouchGenius.TouchFilterTypes.Exclude then
				return true;
			elseif f ~= g and filterType == TouchGenius.TouchFilterTypes.Include then
				return true;
			end
		end
	end
	
	return false;
end



return TouchGenius
