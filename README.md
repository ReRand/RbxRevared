<a href="https://github.com/ReRand/RbxRevared"><img height=100 src="https://github.com/ReRand/RbxRevared/blob/main/Assets/Revared.png?raw=true" alt="Banner">

An open source developer toolkit used in ReRand Roblox games
- Triggers
- Client badges and data stores
- Signals
- Directory fetcher
- 

```lua
local Revared = require(workspace.Revared);
local Trigger = Revared:GetModule("Trigger");

local triggerPart = script.Parent;

local trigger = Trigger.new(triggerPart);

trigger.Entered:Connect(function(character)

end)

```
