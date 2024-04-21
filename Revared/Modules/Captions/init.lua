local TweenService = game:GetService("TweenService");

local player = game.Players.LocalPlayer;
local PlayerGui = player:WaitForChild("PlayerGui");

local Captions = {
	Caption = {}
}


Captions.Caption.__index = {}
local Revared = _G.Revared;
local CaptionStore = Revared.CaptionStore;

local gui = nil;
local tweens = nil;



function Captions.Caption.new(capName: string, capText: string, capSettings)
	capText = capText:gsub("\n", string.char(10));
	
	local capAuthor = nil;
	local rawAuthor = nil;
	
	local capBackground = nil;
	local rawBackground = nil;
	
	
	if capSettings.Author then
		local rawAuthor = capSettings.Author;
		
		local authorText = rawAuthor.Text.Value or rawAuthor.Text;
		authorText = authorText:gsub("\n", string.char(10));
		
		local asettings = {};
		
		for _, setting in pairs(rawAuthor:GetChildren()) do
			if setting.Name ~= "Text" then
				asettings[setting.Name] = setting.Value;
			end
		end
		
		capAuthor = {
			Text = authorText,
			Settings = asettings
		};
	end
	
	
	if capSettings.Background then
		rawBackground = capSettings.Background;
		capBackground = {};

		for _, setting in pairs(rawBackground:GetChildren()) do
			capBackground[setting.Name] = setting.Value;
		end
	end
	
	
	local self = setmetatable({
		Name = capName,
		Author = capAuthor,
		Background = capBackground,
		Text = capText,
		
		Gui = gui,
		Label = label, -- where the hell are you ???
		AuthorLabel = Captions.AuthorLabel, 
		BackgroundFrame = Captions.Background,
		
		Settings = capSettings,
		
		DisplayedBefore = false
		
	}, Captions.Caption);
	
	
	Captions[capName] = self;
	CaptionStore[capName] = self;
	
	
	return self;
end



function Captions.from(thing, capGui, capLabel: string, capBackground: string, capAuthorLabel: string)
	if not capGui then
		gui = script.CaptionGui:Clone();
		gui.Parent = PlayerGui;
	else
		gui = capGui;
	end
	
	label = gui:FindFirstChild(capLabel);
	local authorLabel = gui:FindFirstChild(capAuthorLabel);
	local background = gui:FindFirstChild(capBackground)
	
	label.Transparency = 1;
	label.Visible = true;
	
	authorLabel.Transparency = 1;
	authorLabel.Visible = true;
	
	background.BackgroundTransparency = 1;
	background.Visible = true;
	
	
	Captions.Gui = gui;
	Captions.Label = label;
	Captions.AuthorLabel = authorLabel;
	Captions.Background = background;
	
	
	Captions.BackgroundTweens = {
		In = TweenService:Create(background, TweenInfo.new(0), { 
			BackgroundTransparency = 0.7
		}),
		Out = TweenService:Create(background, TweenInfo.new(0), { 
			BackgroundTransparency = 1,
		}),
	}
	
	
	Captions.Tweens = {
		In = TweenService:Create(label, TweenInfo.new(0), { 
			TextStrokeTransparency = 0,
			TextTransparency = 0,
			BackgroundTransparency = 0.7
		}),
		Out = TweenService:Create(label, TweenInfo.new(0), { 
			Transparency = 1,
		}),
	}
	
	
	Captions.AuthorTweens = {
		In = TweenService:Create(authorLabel, TweenInfo.new(0), { 
			TextStrokeTransparency = 0,
			TextTransparency = 0,
			BackgroundTransparency = 0.7
		}),
		Out = TweenService:Create(authorLabel, TweenInfo.new(0), { 
			Transparency = 1,
		}),
	}
	
	
	if thing.Name then -- an instance instead of a table
		thing = thing:GetChildren();
	end
	
	
	for _, c in pairs(thing) do
		
		local name = c.Name;
		local text = c.Text.Value or c.Text;
		
		local csettings = {}
		
		for _, setting in pairs(c:GetChildren()) do
			if setting.Name ~= "Text" and setting:GetAttribute("Value") then
				csettings[setting.Name] = setting.Value;
			elseif setting:IsA("Folder") then
				csettings[setting.Name] = setting;
			end
		end
		
		Captions.Caption.new(name, text, csettings);	
	end
	
	
	return Captions;
end


function Captions:Display(name)
	local caption = Captions[name];
	local label = caption.Label;
	local authorLabel = caption.AuthorLabel;
	local background = caption.BackgroundFrame;
	
	caption.DisplayedBefore = true;
	
	label.Text = caption.Text;
	
	local _, wordCount = caption.Text:gsub("%S+","")
	
	
	if caption.Author then 
		authorLabel.Text = caption.Author.Text
		
		for settingName, setting in pairs(caption.Author.Settings) do
			if settingName ~= "Author" then
				if Enum:GetEnums()[settingName] then
					authorLabel[settingName] = Enum[settingName][setting];
				else
					authorLabel[settingName] = setting
				end
			end
		end
	end
	
	print(caption);
	
	
	if caption.Background then
		for settingName, setting in pairs(caption.Background) do
			background[settingName] = setting
		end
	end
	
	
	for settingName, setting in pairs(caption.Settings) do
		if settingName ~= "Author" and settingName ~= "Background" then
			if Enum:GetEnums()[settingName] then
				label[settingName] = Enum[settingName][setting];
			else
				label[settingName] = setting
			end
		end
	end
	
	
	Captions.Tweens.In:Play();
	Captions.AuthorTweens.In:Play();
	Captions.BackgroundTweens.In:Play();
	
	
	task.wait(wordCount);
	
	
	Captions.Tweens.Out:Play();
	Captions.AuthorTweens.Out:Play();
	Captions.BackgroundTweens.Out:Play();
end



function Captions:SetTweens(BackgroundInInfo: TweenInfo, BackgroundInTable, BackgroundOutInfo: TweenInfo, BackgroundOutTable,InInfo: TweenInfo, InTable, OutInfo: TweenInfo, OutTable, AuthorInInfo, AuthorInTable, AuthorOutInfo, AuthorOutTable)
	if BackgroundInInfo and BackgroundInTable then Captions.BackgroundTweens.In = TweenService:Create(Captions.Background, BackgroundInInfo, BackgroundInTable); end
	if BackgroundOutInfo and BackgroundOutTable then Captions.BackgroundTweens.Out = TweenService:Create(Captions.Background, BackgroundOutInfo, BackgroundOutTable); end
	
	if InInfo and InTable then Captions.Tweens.In = TweenService:Create(Captions.Label, InInfo, InTable); end
	if OutInfo and OutTable then Captions.Tweens.Out = TweenService:Create(Captions.Label, OutInfo, OutTable); end
	
	if AuthorInInfo and AuthorInTable then Captions.AuthorTweens.In = TweenService:Create(Captions.AuthorLabel, AuthorInInfo, AuthorInTable); end
	if AuthorOutInfo and AuthorOutTable then Captions.AuthorTweens.Out = TweenService:Create(Captions.AuthorLabel, AuthorOutInfo, AuthorOutTable); end
	
	return Captions.Tweens.In, Captions.Tweens.Out, Captions.AuthorTweens.In, Captions.AuthorTweens.Out;
end



return Captions;
