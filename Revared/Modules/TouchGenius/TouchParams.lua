--[[

TouchParams customize how the TouchGenius should behave and should ONLY be accessed using TouchGenius.TouchParams
- Maintain (Boolean) value that decides if it should automatically constantly check for touches that maintain contact for the TouchMaintained event, default false
- MaintainLoopDelay (Number) value that decides how long it should wait inbetween checks for TouchMaintained, default 0
- MaintainFilter (Table) table that handles descendant filtering in TouchMaintained and GetTouchingParts, if something is a descendant of the thing given it'll either include or exclude it depending on the MaintainFilterType, default {}
- MaintainFilterType (Enum.RaycastFilterType) enum accessed through TouchGenius.TouchFilterTypes that decides if filtered things in TouchMaintained/GetTouchingParts should be included or excluded, default Enum.RaycastFilterType.Exclude
- TouchFilter (Table) table that handles descendant filtering in the touch events, if something is a descendant of the thing given it'll either include or exclude it depending on the TouchFilterType, default {}
- TouchFilterType (Enum.RaycastFilterType) enum accessed through TouchGenius.TouchFilterTypes that decides if filtered things in touch events should be included or excluded, default Enum.RaycastFilterType.Exclude
- RawResults (Boolean) value that decides if events should return a TouchResult or a normal Instance, default false
- AsyncWaitingLoopDelay (Number) value that decides how long it should wait inbetween checks for TouchEnded, default 0
- PlayerCheck (Boolean) value that decides if TouchResult should check if the part belongs to a player's humanoid character
- Human Check (Boolean) value that decides if TouchResult should check if the part belongs to a humanoid character

]]




return (function(TouchGenius)
	
	local TouchParams = {};
	TouchParams.__index = TouchParams;


	function TouchParams.new(paramTable)
		if not paramTable then paramTable = {} end;
		
		if not paramTable.Maintain then paramTable.Maintain = false; end
		if not paramTable.MaintainLoopDelay then paramTable.MaintainLoopDelay = 0 end;
		
		if not paramTable.MaintainFilter or (paramTable.MaintainFilter and typeof(paramTable.MaintainFilter) ~= "table") then paramTable.MaintainFilter = {}; end
		if not paramTable.MaintainFilterType then paramTable.MaintainFilterType = TouchGenius.TouchFilterTypes.Exclude end
		
		if not paramTable.TouchFilter or (paramTable.TouchFilter and typeof(paramTable.TouchFilter) ~= "table") then paramTable.TouchFilter = {}; end
		if not paramTable.TouchFilterType then paramTable.TouchFilterType = TouchGenius.TouchFilterTypes.Exclude end
		
		if not paramTable.RawResults then paramTable.RawResults = false end;
		
		if not paramTable.AsyncWaitingLoopDelay then paramTable.AsyncWaitingLoopDelay = 0 end;
		
		if not paramTable.PlayerCheck then paramTable.PlayerCheck = true end;
		if not paramTable.HumanCheck then paramTable.HumanCheck = true end;
		
		
		local self = setmetatable({
			Maintain = paramTable.Maintain,
			MaintainLoopDelay = paramTable.MaintainLoopDelay,
			
			MaintainFilter = paramTable.MaintainFilter,
			MaintainFilterType = paramTable.MaintainFilterType,
			
			TouchFilter = paramTable.TouchFilter,
			TouchFilterType = paramTable.MaintainFilterType,
			
			RawResults = paramTable.RawResults,
			
			AsyncWaitingLoopDelay = paramTable.AsyncWaitingLoopDelay,
			
			PlayerCheck = paramTable.PlayerCheck,
			HumanCheck = paramTable.HumanCheck,
			
			ParamTable = paramTable
			
		}, TouchParams);

		return self;
	end
	
	
	
	function TouchParams:AddToMaintainFilter(instances)
		if typeof(instances) == "table" then
			for _, i in pairs(instances) do
				table.insert(self.MaintainFilter, i);
			end
		else
			table.insert(self.MaintainFilter, instances);
		end
	end



	return TouchParams;

end)
