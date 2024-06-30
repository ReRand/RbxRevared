return (function(TouchGenius)
	
	local TouchParams = {};
	TouchParams.__index = TouchParams;


	function TouchParams.new(paramTable)
		if not paramTable then paramTable = {} end;
		
		if not paramTable.Maintain then paramTable.Maintain = true; end
		if not paramTable.MaintainLoopDelay then paramTable.MaintainLoopDelay = 0 end;
		
		if not paramTable.MaintainFilter or (paramTable.MaintainFilter and typeof(paramTable.MaintainFilter) ~= "table") then paramTable.MaintainFilter = {}; end
		if not paramTable.MaintainFilterType then paramTable.MaintainFilterType = TouchGenius.TouchFilterTypes.Exclude end
		
		if not paramTable.TouchFilter or (paramTable.TouchFilter and typeof(paramTable.TouchFilter) ~= "table") then paramTable.TouchFilter = {}; end
		if not paramTable.TouchFilterType then paramTable.TouchFilterType = TouchGenius.TouchFilterTypes.Exclude end
		
		if not paramTable.RawResults then paramTable.RawResults = false end;
		
		
		local self = setmetatable({
			Maintain = paramTable.Maintain,
			MaintainLoopDelay = paramTable.MaintainLoopDelay,
			
			MaintainFilter = paramTable.MaintainFilter,
			MaintainFilterType = paramTable.MaintainFilterType,
			
			TouchFilter = paramTable.TouchFilter,
			TouchFilterType = paramTable.MaintainFilterType,
			
			RawResults = paramTable.RawResults,
			
			ParamTable = paramTable
			
		}, TouchParams);

		return self;
	end



	return TouchParams;

end)
