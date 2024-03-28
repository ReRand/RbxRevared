local RelKit = {};
local resources = script:GetChildren();


for _, res in pairs(resources) do
    RelKit[res.Name] = require(res);
end


function RelKit:GetService(service: string)
    return RelKit[service];
end


return RelKit;
