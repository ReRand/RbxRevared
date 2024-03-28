local Revared = {};
local resources = script:GetChildren();


for _, res in pairs(resources) do
    Revared[res.Name] = require(res);
end


function Revared:GetService(service: string)
    return Revared[service];
end


return Revared;
