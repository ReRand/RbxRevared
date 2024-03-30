<a href="https://github.com/ReRand/RbxRevared"><img height=100 src="https://github.com/ReRand/RbxRevared/blob/main/Assets/Revared.png?raw=true" alt="Banner">

An open source developer toolkit used in ReRand Roblox games
- Advanced Triggers
- Client-side badges and data stores
- Global-side stuff
- Custom Script Signals
- Directory fetching

<br>

```lua
local Revared = require(workspace.Revared);


local Trigger = Revared:GetModule("Trigger"); -- gets the trigger module
local GlobalSide = Revared:GetModule("GlobalSide"); -- gets the global-sided values module


local triggerPart = script.Parent;


local trigger = Trigger.new(triggerPart); -- creates a new trigger with the part
trigger:Visualize(); -- makes the trigger visible with a special texture


trigger.Entered:Connect(function(character) -- when the player enters the trigger it damages them
    print("entered");
    GlobalSide:Damage(character, 50);
end)


trigger.Exited:Connect(function(character) -- when the player exits the trigger it heals them
    print("exited");
    GlobalSide:Heal(character, 50);
end)


trigger:Activate(); -- activates the trigger
```
