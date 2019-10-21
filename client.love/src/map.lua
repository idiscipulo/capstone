local sti = require 'libs.sti'

Map = {}
Map.__index = Map

function Map:new()
    local map = {}
    setmetatable(map, Map)

    map.image = sti('assets/first_map.lua')
    map.image:addCustomLayer("Sprite Layer", 3)
    local spriteLayer = map.image.layers["Sprite Layer"]
    
	spriteLayer.sprites = {}
	function spriteLayer:update(dt)
        for _, sprite in pairs(self.sprites) do 
            sprite:update() 
        end
    end
    
	function spriteLayer:draw()
        for _, sprite in pairs(self.sprites) do 
            sprite:draw() 
        end
    end

    return map
end