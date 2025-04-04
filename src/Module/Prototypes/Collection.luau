--!optimize 2
--!nonstrict
--!native

local Nodes = require(script.Parent.Parent.Nodes)
local RunService = game:GetService("RunService")


function Nodes.Collection.New<K,V>(items: { [number]: { [number]: K | V } }?) : Nodes._Collection<K,V>
	local items: { [number]: { [number]: K | V } } = items or {}
	
	return Nodes.Init(items, Nodes.Collection) :: Nodes._Collection<K,V>
end


function Nodes.Collection.Prototype:Add(key, value, index: number?): number
	local index = index or #self
	table.insert(self, index, { key, value })
	return index
end


function Nodes.Collection.Prototype:GetEntries() : { [number]: { [number]: any } }
	local t = {}
	for i, e in self do
		if typeof(i) == "number" then
			t[i] = e
		end
	end
	return t
end


function Nodes.Collection.Prototype:GetItems() : { [any]: any }
	local t = {}
	for i, e in self:GetEntries() do
		t[e[1]] = e[2]
	end
	return t
end


function Nodes.Collection.Prototype:ForEach(callback: (k: any, v: any, i: number?) -> nil)

end


function Nodes.Collection.Prototype:Filter()
	local n = self:Clone()
end


return Nodes.Collection :: Nodes._CollectionStatic