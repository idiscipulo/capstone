-- parent class for characters 

Character = {}
Character.__index = Character

function Character:new()
    local character = {}
    setmetatable(character, Character)

    -- icon
    character.icon = nil

    -- sprite
    character.sprite = Sprite:new()

    -- max and current health
    character.maxHealth = 0
    character.curHealth = 0

    -- death tracker
    character.deathTime = 0

    -- dots table
    character.dots = {}

    -- name
    character.name = nil

    -- abilities table
    character.abilities = {}

    return character
end

function Character:update()
    -- update dots
    for ind, val in pairs(self.dots) do
        val:tick()
    end

    -- update sprite
    self.sprite:update()
end

function Character:draw()
end

function Character:endAbility()
    -- set proper x and y coordinates for ability icons based on order
    for ind, val in pairs(self.abilities) do
        val.x = 12 + ((ind - 1) * 102)
        val.y = 510
    end
end

function Character:addAbility(ab)
    -- add and attach ability
    self.abilities[#self.abilities + 1] = ab
    ab:attach(self)
end

function Character:damage(amt)
    -- deal damage
    self.curHealth = math.max(self.curHealth - amt, 0)

    -- get index for next open spot in numbers
    local ind = #stateList['battle'].numbers + 1

    -- add damage number to numbers
    stateList['battle'].numbers[ind] = Number:new(ind, self, amt, 'DAMAGE')
end

function Character:heal(amt)
    -- check if character is missing health
    if self.curHealth < self.maxHealth then
        -- heal
        self.curHealth = math.min(self.curHealth + amt, self.maxHealth)

        -- get index for next open spot in numbers
        local ind = #stateList['battle'].numbers + 1

        -- add healing number to numbers
        stateList['battle'].numbers[ind] = Number:new(ind, self, amt, 'HEAL')
    end
end