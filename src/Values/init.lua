local Values = {
	RemoteValue = require(script.RemoteValue);
}



function Values:FetchLocal(value: string)
	for i0, v0 in pairs( script.Local:GetChildren() ) do
		if v0:IsA("Folder") then
			for i1, v1 in pairs( v0:GetChildren() ) do
				if v1.Name == value then 
					return v1;
				end
			end
		elseif v0.Name == value and v0:GetAttribute("Value") then 
			return v0;
		end
	end
end


function Values:FetchServer(value: string)
	for i0, v0 in pairs( script.Server:GetChildren() ) do
		if v0:IsA("Folder") then
			for i1, v1 in pairs( v0:GetChildren() ) do
				if v1.Name == value then 
					return v1;
				end
			end
		elseif v0.Name == value and v0:GetAttribute("Value") then 
			return v0;
		end
	end
end


function Values:FetchRemote(value: string, player)
	if typeof(player) == "string" then player = game.Players:GetPlayerByUserId(player); end
	return Values.RemoteValue.new(player, value);
end


function Values:FetchFrom(value: string, dir)
	for i0, v0 in pairs( dir:GetChildren() ) do
		if v0:IsA("Folder") then
			for i1, v1 in pairs( v0:GetChildren() ) do
				if v1.Name == value then 
					return v1;
				end
			end
		elseif v0.Name == value and v0:GetAttribute("Value") then 
			return v0;
		end
	end
end


return Values