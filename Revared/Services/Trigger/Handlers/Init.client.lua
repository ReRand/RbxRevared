local RunService = game:GetService("RunService");
local rep = game:GetService("ReplicatedStorage");

local character = script.Parent.Parent.Parent;

local id = script.Parent.Name;
local inEvent = rep.TriggerEvents[id].InEvent;
local outEvent = rep.TriggerEvents[id].OutEvent;


local touchBoolean = false;


inEvent.OnClientEvent:Connect(function(partSects, id, triggerSettings)
	
	local TouchPart = nil;
	
	
	if (not character:FindFirstChild("TriggerHitbox?trigid="..id)) then
		TouchPart = Instance.new("Part", character);
		TouchPart.Name = "TriggerHitbox?trigid="..id;
		TouchPart.Anchored = true;
		TouchPart.CanCollide = false;
		TouchPart.Size = Vector3.new(1, 1, 1);
		TouchPart.Transparency = 1;


		local offset = Instance.new("Vector3Value", TouchPart);
		offset.Name = "Offset";
		
		
		local TouchConnection = TouchPart.Touched:Connect(function() end);
		
		
		if (triggerSettings) then
			if (triggerSettings.Hitbox) then
				for name, setting in ipairs(triggerSettings.Hitbox) do
					TouchPart[name] = setting;
				end
			end

			if (triggerSettings.Offset) then
				offset.Value = triggerSettings.Offset;
			end

			if (triggerSettings.Size) then
				TouchPart.Size = triggerSettings.Size;
			end
		end
	else
		TouchPart = character["TriggerHitbox?trigid="..id]
	end
	
	
	RunService.RenderStepped:Connect(function()
		local triggerPart = game;


		for _, child in ipairs(partSects) do
			triggerPart = triggerPart[child];
		end


		local function GetParts()
			local HumanoidRootPart = character:FindFirstChild("HumanoidRootPart");

			if HumanoidRootPart then
				TouchPart.CFrame = HumanoidRootPart.CFrame + TouchPart.Offset.Value;
				return TouchPart:GetTouchingParts();
			end
		end



		local function IsTouching(part)
			for _, touchedPart in ipairs(GetParts()) do
				if (touchedPart.name == part.name) then return true end
			end

			return false;
		end
		
		
		if (IsTouching(triggerPart) and not touchBoolean and triggerPart.TriggerEnabled.Value) then

			touchBoolean = true;
			outEvent:FireServer(1);

		elseif (not IsTouching(triggerPart)) then
			
			if (touchBoolean) then outEvent:FireServer(2) end
			touchBoolean = false;
		end
	end);
end)
