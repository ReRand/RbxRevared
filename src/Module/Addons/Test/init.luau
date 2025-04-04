local Nodes = require(script.Parent.Parent.Nodes)


do local n, t = Nodes.New("Test", "Node") Nodes[n] = t :: _TestStatic end
export type _TestStatic = Nodes._BaseStaticNode & {
	New : <T>(guh: T) -> _Test<T>,
}
export type _Test<T> = Nodes._Node & {}


return Nodes