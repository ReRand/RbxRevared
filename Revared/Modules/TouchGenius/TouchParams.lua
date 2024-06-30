local TouchParams = {};
TouchParams.__index = TouchParams;



function TouchParams.new(paramTable)
	if not paramTable then paramTable = {} end;
	
	if not paramTable.Maintain then paramTable.Maintain = true; end
	if not paramTable.MaintainLoopDelay then paramTable.MaintainLoopDelay = 0 end;
	if not paramTable.Filter or (paramTable.Filter and typeof(paramTable) ~= "table") then paramTable.Filter = {}; end
	if not paramTable.RawResults then paramTable.RawResults = false end;
	
	
	local self = setmetatable({
		Maintain = paramTable.Maintain,
		MaintainLoopDelay = paramTable.MaintainLoopDelay,
		Filter = paramTable.Filter,
		RawResults = paramTable.RawResults,
		
		ParamTable = paramTable
		
	}, TouchParams);

	return self;
end



return TouchParams;
