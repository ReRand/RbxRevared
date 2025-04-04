local Nodes = require(script.Parent.Parent.Parent.Parent.Nodes)
local Test = require(script.Parent.Parent)


function Nodes.Test.New<T>(guh: T): Test._Test<T>
    return Nodes.Init({}, Nodes.Test) :: Test._Test<T>
end


return Nodes.Test :: Test._TestStatic