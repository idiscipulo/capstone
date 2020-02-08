Node = {}
Node.__index = Node

function Node:new(x, y, c, parent, child)
    local node = {}
    setmetatable(node, Node)

    node.x = x
    node.y = y
    node.c = c
    node.path = {}

    return node
end