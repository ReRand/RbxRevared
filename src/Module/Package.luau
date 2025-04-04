local Nodes =  require(script.Parent.Nodes)
local Test = require(script.Parent.Addons.Test)

export type _NodePackage = {
	Enums: {},
	New: (NodeName: string, ...any) -> (string, Nodes._BaseStaticNode),
	Init: (self: { [any]: any }, from: { [any]: any }) -> any,
	Spawn: <T>(name : string, ...any) -> T,

	Node: Nodes._NodeStatic,
	Collection: Nodes._CollectionStatic,
	CollectionItem: Nodes._CollectionItemStatic,
	Entity: Nodes._EntityStatic,
	EntityInfo: Nodes._EntityInfoStatic,
	Item: Nodes._ItemStatic,
	Projectile: Nodes._ProjectileStatic,
	ProjectileInfo: Nodes._ProjectileInfoStatic,
	ExplosionInfo: Nodes._ExplosionInfoStatic,
	FireInfo: Nodes._FireInfoStatic,
	Explosion: Nodes._ExplosionStatic,
	Fire: Nodes._FireStatic,
	Signal: Nodes._Signal<...any>,
	Root: Nodes._RootStatic,

	Test: Test._TestStatic
}

return {}