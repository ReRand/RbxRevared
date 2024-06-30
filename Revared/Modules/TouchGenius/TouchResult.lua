local TouchResult = {};
TouchResult.__index = TouchResult;



function TouchResult.new(touchGenius, hit, state)
	local part = touchGenius.Part;
	
	
	local surfaces = {
		[Enum.NormalId.Back] = part.CFrame * CFrame.new(0, 0, part.Size.Z);
		[Enum.NormalId.Front] = part.CFrame * CFrame.new(0, 0, -part.Size.Z);
		[Enum.NormalId.Top] = part.CFrame * CFrame.new(0, part.Size.Y, 0);
		[Enum.NormalId.Bottom] = part.CFrame * CFrame.new(0, -part.Size.Y, 0);
		[Enum.NormalId.Right] = part.CFrame * CFrame.new(part.Size.X, 0, 0);
		[Enum.NormalId.Left] = part.CFrame * CFrame.new(-part.Size.X, 0, 0);
	}
	
	local surface = Enum.NormalId.Front;
	
	
	for side, cframe in pairs(surfaces) do
		surface = ((hit.Position - cframe.p).Magnitude > (hit.Position - surfaces[surface].p).Magnitude and surface or side)
	end
	
	local distance = (part.Position - hit.Position).Magnitude
	
	
	local self = setmetatable({
		Instance = hit,
		Distance = distance,
		
		Position = hit.Position,
		Rotation = hit.Rotation,
		CFrame = hit.CFrame,
		
		SideTouched = surface,
		Normal = Vector3.new(),
		Material = hit.Material,
		
		TouchGenius = touchGenius,
		
		TouchState = state
		
	}, TouchResult);
	
	
	local params = RaycastParams.new()
	params.FilterDescendantsInstances = { hit, part };
	params.FilterType = Enum.RaycastFilterType.Include;


	local direction = (hit.Position - part.Position).Unit;
	local result = workspace:Raycast(part.Position, direction*10, params)
	self.Raycast = result;


	if result then
		self.Distance = result.Distance;
		self.Normal = result.Normal;
	end
	
	
	return self;
end




return TouchResult;
