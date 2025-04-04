--!optimize 2
--!nonstrict
--!native

--[[
                                                                                   
                                                                                   
,-.----.       ,---,.               ,---,       ,-.----.       ,---,.    ,---,     
\    /  \    ,'  .' |       ,---.  '  .' \      \    /  \    ,'  .' |  .'  .' `\   
;   :    \ ,---.'   |      /__./| /  ;    '.    ;   :    \ ,---.'   |,---.'     \  
|   | .\ : |   |   .' ,---.;  ; |:  :       \   |   | .\ : |   |   .'|   |  .`\  | 
.   : |: | :   :  |-,/___/ \  | |:  |   /\   \  .   : |: | :   :  |-,:   : |  '  | 
|   |  \ : :   |  ;/|\   ;  \ ' ||  :  ' ;.   : |   |  \ : :   |  ;/||   ' '  ;  : 
|   : .  / |   :   .' \   \  \: ||  |  ;/  \   \|   : .  / |   :   .''   | ;  .  | 
;   | |  \ |   |  |-,  ;   \  ' .'  :  | \  \ ,';   | |  \ |   |  |-,|   | :  |  ' 
|   | ;\  \'   :  ;/|   \   \   '|  |  '  '--'  |   | ;\  \'   :  ;/|'   : | /  ;  
:   ' | \.'|   |    \    \   `  ;|  :  :        :   ' | \.'|   |    \|   | '` ,/   
:   : :-'  |   :   .'     :   \ ||  | ,'        :   : :-'  |   :   .';   :  .'     
|   |.'    |   | ,'        '---" `--''          |   |.'    |   | ,'  |   ,.'       
`---'      `----'                               `---'      `----'    '---'         
                                                                                   

Created by shysolocup :: ReRAND STUDIOS


]]


for _, mod: ModuleScript in script:GetDescendants() do
	if mod:IsA("ModuleScript") then
		require(mod)
	end
end


switch = function(cases,arg)
	return assert (loadstring ('return ' .. cases[arg]))()
end


local Revared = {
	Addons = script.Addons,
    Nodes = script.Nodes,
	Events = script.Events.Revared,
	Root = nil,
}


local RunService = game:GetService("RunService")
local Nodes = require(script.Nodes)


function Revared.GetRoot(): Nodes._Root
	return RunService:IsClient() and Revared.Events.GetRoot:InvokeServer() or Revared.Root
end


type _Revared = {
	Addons: Folder,
	Nodes: ModuleScript,
	Enums: {},
	Root: Nodes._Root,
	Events: Folder,
	Ready: boolean,

	SpawnNode: <T>(name : string, ...any) -> T,
	GetRoot: () -> Nodes._Root,
}


Revared.SpawnNode = Nodes.Spawn
Revared.Enums = Nodes.Enums


return Revared :: _Revared