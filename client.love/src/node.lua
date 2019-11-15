Node = {}
Node.__index = Node

function Node:new(x, y, c, parent, child)
    local node = {}
    setmetatable(node, Node)

    node.x = x
    node.y = y
    node.c = c
    node.parent = parent
    node.child = child

    return node
end