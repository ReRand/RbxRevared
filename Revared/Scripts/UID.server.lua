local HttpService = game:GetService("HttpService");

game.ChildAdded:Connect(function(child)
	child:SetAttribute("UID", HttpService:GenerateGUID(false))
end)
