local DataStoreService = game:GetService("DataStoreService");


local DataStores = require(script.Parent.Parent.Parent);
local events = script.Parent.Parent.Parent.Events;


local request = events.Request;
local post = events.Post;
local out = events.Out;


request.OnServerEvent:Connect(function(player, dataStore, scope, key)
    local store = DataStoreService:GetDataStore(dataStore, scope);

    local data = store:GetAsync(tostring(key));

    out:FireClient(player, DataStores.Types.Request, data);
end);


post.OnServerEvent:Connect(function(player, dataStore, scope, key, data)
    local store = DataStoreService:GetDataStore(dataStore, scope);

    store:SetAsync(tostring(key), data);

    out:FireClient(player, DataStores.Types.Post, data);
end);
