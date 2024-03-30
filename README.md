<a href="https://github.com/ReRand/RbxRevared"><img height=100 src="https://github.com/ReRand/RbxRevared/blob/main/Assets/Revared.png?raw=true" alt="Banner">

An open source developer toolkit used in ReRand Roblox games
- Advanced Triggers
- Client badges and data stores
- Global sided values
- Custom Script Signals
- Directory fetcher


```lua
local Revared = require(workspace.Revared);
local Trigger = Revared:GetModule("Trigger");
local GlobalSide = Revared:GetModule("GlobalSide");
local triggerPart = script.Parent;


local trigger = Trigger.new(triggerPart);
trigger:Visualize();


trigger.Entered:Connect(function(character)
    print("entered");
    GlobalSide:Damage(character, 50);
end)


trigger.Exited:Connect(function(character)
    print("exited");
    GlobalSide:Heal(character, 50);
end)


trigger:Activate();
```
