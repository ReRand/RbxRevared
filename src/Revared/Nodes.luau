--!optimize 2
--!nonstrict
--!native

local LemonSignal = require(script.Parent.Parent.LemonSignal)
local RunService = game:GetService("RunService")


local Nodes = {
	Enums = {},
	UID = 0
}


function Nodes.Spawn<T>(name : string, ...): T
	return Nodes[name].New(...) :: T
end


type _NodeParameters = {
	Destroyable: boolean?,
	Readonly: boolean?,
	Repilcable: boolean?,
	["Server" | "Client"]: _NodeParameters?
}


function Nodes.New( Config: _NodeParameters, NodeName: string, ...): (string, _BaseStaticNode)
	table.freeze(Config)
	
	local self = {
		NodeName =  NodeName,
		Extensions = #{...} > 0 and {...} or {},
		Prototype = {},

		Config = Config,

		GetConfig = function(self: _BaseStaticNode) : _NodeParameters
			return (RunService:IsClient() and self.Config["Client"]) and self.Config["Client"] 
				or (RunService:IsServer() and self.Config["Server"]) and self.Config["Server"]
				or self.Config
		end
	}

	table.freeze(self)
	table.freeze(self.Extensions)

	return NodeName, (self :: _BaseStaticNode)
end


local function extend(self, from)
	for _, t in from.Extensions do
		local node = Nodes[t]
		for k, v in node.Prototype do
			self[k] = self[k] or v
		end

		extend(self, node)
	end
end


function Nodes.Init(self: { [any]: any }, from: { [any]: any })
	self.Node = from
	self.Metadata = self.Metadata or {}
	self.Children = self.Children or {}
	self.Parent = self.Parent
	self.Index = self.Index or 1

	self.UID = Nodes.UID
	Nodes.UID += 1

	-- inherit from node type's prototype
	for k, v in from.Prototype do
		self[k] = self[k] or v
	end

	-- inherit from node's extensions
	extend(self, from)

	local config = from:GetConfig()

	return self
end



function Nodes.GetConfig(from: _BaseStaticNode) : _NodeParameters
	return (RunService:IsClient() and from.Config["Client"]) and from.Config["Client"] 
		or (RunService:IsServer() and from.Config["Server"]) and from.Config["Server"]
		or from.Config
end



export type _BaseStaticNode = {
	NodeName: string,
	Extensions: { [number]: string },
	Prototype: _Node,
	Config: _NodeParameters,

	GetConfig: (self: _BaseStaticNode) -> _NodeParameters
}



export type _Signal<T> = LemonSignal.Signal
Nodes.Signal = LemonSignal



--[[ Ace Class ]]--
-- extends into almost every class
-- contains base information for classes
do local n, t = Nodes.New({}, "Node") Nodes[n] = t :: _NodeStatic end
export type _NodeStatic = _BaseStaticNode & {
	New : () -> _Node,
}
export type _Node = {
	Node : _BaseStaticNode,
	Metadata: {},
	Children: {},
	Parent: _Node,

	Destroy : (self : any) -> nil,
	Clone : (self : any) -> _Node,
	AddChild : (self : any, name : string, ...any) -> _Node,
	Message : (self: any, player: Player?) -> _Node
}



--[[ Ace Game ]]--
-- extends into almost every class
-- contains base information for classes
do local n, t = Nodes.New({ Readonly = true, Destroyable = false }, "Root", "Node") Nodes[n] = t :: _RootStatic end
export type _RootStatic = _BaseStaticNode & {
	New : () -> _Root,
}
export type _Root = {
	Entities: _Collection<string, _Entity>
}



--[[ Ace Entity ]]--
-- entity class covering ai and players
do local n, t = Nodes.New({ Client = { Readonly = true, Destroyable = false } }, "Entity", "Node") Nodes[n] = t :: _EntityStatic end
export type _EntityStatic = _BaseStaticNode & {
	New : (info : _EntityInfo?) -> _Entity?,
}
export type _Entity = _Node & {
	StarterCharacter: Model?,
	Character: Model?,
	Hitbox: Model?,

	Health: number,
	Gravity: number,
	
	Standing: boolean,
	Jumping: boolean,

	Inventory: _Collection<number, _Item>,

	Kill: (self: any, reason: string) -> any,
	Killed: _Signal<string>
}



--[[ Ace Entity Info ]]--
-- info for entity instances
do local n, t = Nodes.New({}, "EntityInfo", "Node") Nodes[n] = t :: _EntityInfoStatic end
export type _EntityInfoStatic = _BaseStaticNode & {
	New : (info: _EntityInfo?) -> _EntityInfo,
}
export type _EntityInfo = _Node & {
	Kill : (reason: string) -> nil,

}



--[[ Ace Collection ]]--
-- collection of entities with functions relating to them
do local n, t = Nodes.New({}, "Collection", "Node") Nodes[n] = t :: _CollectionStatic end
export type _CollectionStatic = _BaseStaticNode & {
	New : <K,V>(items: { [number]: { [number]: K | V } }?) -> _Collection<K,V>,
}
export type _Collection<K,V> = _Node & { 
	[number]: _CollectionItem<K,V>,

	Add: (self: any, key: K, value: V) -> _CollectionItem<K,V>,
	GetItems: (self: any) -> { [K]: V },
	ForEach: (self: any, callback: (k: K, v: V, i: number?) -> nil) -> nil
}



--[[ Ace Collection Item ]]--
-- collection of entities with functions relating to them
do local n, t = Nodes.New({}, "CollectionItem", "Node") Nodes[n] = t :: _CollectionItemStatic end
export type _CollectionItemStatic = _BaseStaticNode & {
	New : <K,V>(key: K, value: V) -> _CollectionItem<K,V>,
}
export type _CollectionItem<K,V> = _Node & { 
	Key: K,
	Value: V?
}



--[[ Ace Item ]]--
-- inventory item
do local n, t = Nodes.New({ Client = { Readonly = true, Destroyable = false }}, "Item", "Node") Nodes[n] = t :: _ItemStatic end
export type _ItemStatic = _BaseStaticNode & {
	New : () -> _Item,
}
export type _Item = _Node & {
	Name : string,
	Id : string,

	Use: (_Item) -> any?,
	Used: LemonSignal.Signal<_Projectile>
}



--[[ Ace Projectile ]]--
-- projectiles fired from weapons
do local n, t = Nodes.New({ Client = {Readonly = true, Destroyable = false} }, "Projectile", "Node") Nodes[n] = t :: _ProjectileStatic end
export type _ProjectileStatic = _BaseStaticNode & {
	New : () -> _Projectile,
}
export type _Projectile = _Node & {
	Name : string,
	Id: string,

	Info : _ProjectileInfo,

	Hit : LemonSignal.Signal<Part>
}



--[[ Ace Projectile Info ]]--
-- info about projectiles
do local n, t = Nodes.New({}, "ProjectileInfo", "Node") Nodes[n] = t :: _ProjectileInfoStatic end
export type _ProjectileInfoStatic = _BaseStaticNode & {
	New : (info: _ProjectileInfo) -> _ProjectileInfo,
}
export type _ProjectileInfo = _Node & {

}



--[[ Ace Explosion Info ]]--
-- info for explosion instances
do local n, t = Nodes.New({}, "ExplosionInfo", "Node") Nodes[n] = t :: _ExplosionInfoStatic end
export type _ExplosionInfoStatic = _BaseStaticNode & {
	New : (projectile: _Projectile, info: _ExplosionInfo) -> _ExplosionInfo,
}
export type _ExplosionInfo = _Node & {
	FilterType : Enum.RaycastFilterType,
	Filter : { [number] : Instance },

	OriginProjectile : _Projectile,

	MultiHit : boolean,
	FuseTime : number,
	Knockback : boolean,
	KnockbackMultiplier : number,
	Cooldown : number,
	Velocity : number,
	SetDamage : number | boolean, -- if SetDamage is false then it'll not do anything if it's set to a number it'll use that damage
	FallVelocity : number,

	Radius : number,
	Color : Color3 | BrickColor,
	Transparency : number?,

	FireProbability : number,
	FireInfo : _FireInfo?,
}



--[[ Ace Fire Info ]]--
-- info for fire instances
do local n, t = Nodes.New({}, "FireInfo", "Node") Nodes[n] = t :: _FireInfoStatic end
export type _FireInfoStatic = _BaseStaticNode & {
	New : (entity: _Entity, info: _FireInfo) -> _FireInfo,
}
export type _FireInfo = _Node & {
	Color : Color3 | BrickColor,
	Transparency : number,

	OriginEntity : _Entity,

	Damage : number,
	TickTime : number,
	TotalTime : number,
}



--[[ Ace Explosion ]]--
-- big booms
do local n, t = Nodes.New({ Client = { Readonly = true, Destroyable = false }}, "Explosion", "Node") Nodes[n] = t :: _ExplosionStatic end
export type _ExplosionStatic = _BaseStaticNode & {
	New : (info: _ExplosionInfo?) -> _Explosion?,
}
export type _Explosion = _Node & {
	Info : _ExplosionInfo
}



--[[ Ace Fire ]]--
-- big burn hot
do local n, t = Nodes.New({ Client = { Readonly = true, Destroyable = false }}, "Fire", "Node") Nodes[n] = t :: _FireStatic end
export type _FireStatic = _BaseStaticNode & {
	New : (info: _FireInfo?) -> _Fire?,
}
export type _Fire = _Node & {
	Info : _FireInfo
}


local Package = require(script.Parent.Package)
return Nodes :: Package._NodePackage