-- lol, i don't even know how this works 100% anymore (isaiah)

Font = {} -- create class
Font.__index = Font -- set meta name

function Font:new()
    local font = {} -- create local
    setmetatable(font, Font) -- set meta table (obvs)

    font.letters = {} -- create letter dictionary

    font.letters['A'] = love.graphics.newImage('img/font.a.caps.png')
    font.letters['B'] = love.graphics.newImage('img/font.b.caps.png')
    font.letters['C'] = love.graphics.newImage('img/font.c.caps.png')
    font.letters['D'] = love.graphics.newImage('img/font.d.caps.png')
    font.letters['E'] = love.graphics.newImage('img/font.e.caps.png')
    font.letters['F'] = love.graphics.newImage('img/font.f.caps.png')
    font.letters['G'] = love.graphics.newImage('img/font.g.caps.png')
    font.letters['H'] = love.graphics.newImage('img/font.h.caps.png')
    font.letters['I'] = love.graphics.newImage('img/font.i.caps.png')
    font.letters['J'] = love.graphics.newImage('img/font.j.caps.png')
    font.letters['K'] = love.graphics.newImage('img/font.k.caps.png')
    font.letters['L'] = love.graphics.newImage('img/font.l.caps.png')
    font.letters['M'] = love.graphics.newImage('img/font.m.caps.png')
    font.letters['N'] = love.graphics.newImage('img/font.n.caps.png')
    font.letters['O'] = love.graphics.newImage('img/font.o.caps.png')
    font.letters['P'] = love.graphics.newImage('img/font.p.caps.png')
    font.letters['Q'] = love.graphics.newImage('img/font.q.caps.png')
    font.letters['R'] = love.graphics.newImage('img/font.r.caps.png')
    font.letters['S'] = love.graphics.newImage('img/font.s.caps.png')
    font.letters['T'] = love.graphics.newImage('img/font.t.caps.png')
    font.letters['U'] = love.graphics.newImage('img/font.u.caps.png')
    font.letters['V'] = love.graphics.newImage('img/font.v.caps.png')
    font.letters['W'] = love.graphics.newImage('img/font.w.caps.png')
    font.letters['X'] = love.graphics.newImage('img/font.x.caps.png')
    font.letters['Y'] = love.graphics.newImage('img/font.y.caps.png')
    font.letters['Z'] = love.graphics.newImage('img/font.z.caps.png')

    font.letters['a'] = love.graphics.newImage('img/font.a.png')
    font.letters['b'] = love.graphics.newImage('img/font.b.png')
    font.letters['c'] = love.graphics.newImage('img/font.c.png')
    font.letters['d'] = love.graphics.newImage('img/font.d.png')
    font.letters['e'] = love.graphics.newImage('img/font.e.png')
    font.letters['f'] = love.graphics.newImage('img/font.f.png')
    font.letters['g'] = love.graphics.newImage('img/font.g.png')
    font.letters['h'] = love.graphics.newImage('img/font.h.png')
    font.letters['i'] = love.graphics.newImage('img/font.i.png')
    font.letters['j'] = love.graphics.newImage('img/font.j.png')
    font.letters['k'] = love.graphics.newImage('img/font.k.png')
    font.letters['l'] = love.graphics.newImage('img/font.l.png')
    font.letters['m'] = love.graphics.newImage('img/font.m.png')
    font.letters['n'] = love.graphics.newImage('img/font.n.png')
    font.letters['o'] = love.graphics.newImage('img/font.o.png')
    font.letters['p'] = love.graphics.newImage('img/font.p.png')
    font.letters['q'] = love.graphics.newImage('img/font.q.png')
    font.letters['r'] = love.graphics.newImage('img/font.r.png')
    font.letters['s'] = love.graphics.newImage('img/font.s.png')
    font.letters['t'] = love.graphics.newImage('img/font.t.png')
    font.letters['u'] = love.graphics.newImage('img/font.u.png')
    font.letters['v'] = love.graphics.newImage('img/font.v.png')
    font.letters['w'] = love.graphics.newImage('img/font.w.png')
    font.letters['x'] = love.graphics.newImage('img/font.x.png')
    font.letters['y'] = love.graphics.newImage('img/font.y.png')
    font.letters['z'] = love.graphics.newImage('img/font.z.png')

    font.letters['0'] = love.graphics.newImage('img/font.0.png')
    font.letters['1'] = love.graphics.newImage('img/font.1.png')
    font.letters['2'] = love.graphics.newImage('img/font.2.png')
    font.letters['3'] = love.graphics.newImage('img/font.3.png')
    font.letters['4'] = love.graphics.newImage('img/font.4.png')
    font.letters['5'] = love.graphics.newImage('img/font.5.png')
    font.letters['6'] = love.graphics.newImage('img/font.6.png')
    font.letters['7'] = love.graphics.newImage('img/font.7.png')
    font.letters['8'] = love.graphics.newImage('img/font.8.png')
    font.letters['9'] = love.graphics.newImage('img/font.9.png')

    font.letters[' '] = love.graphics.newImage('img/font.space.png')
    font.letters['\''] = love.graphics.newImage('img/font.apos.png')
    font.letters['/'] = love.graphics.newImage('img/font.slash.png')
    font.letters['.'] = love.graphics.newImage('img/font.period.png')
    font.letters[','] = love.graphics.newImage('img/font.comma.png')
    font.letters[':'] = love.graphics.newImage('img/font.colon.png')
    font.letters['%'] = love.graphics.newImage('img/font.percent.png')
    font.letters['['] = love.graphics.newImage('img/font.lbracket.png')
    font.letters[']'] = love.graphics.newImage('img/font.rbracket.png')
    font.letters['~'] = love.graphics.newImage('img/font.~.png')
    font.letters['+'] = love.graphics.newImage('img/font.plus.png')

    return font
end

function Font:print(text, x, y) -- single line print
    for i = 1, #text do -- for each character
        local c = text:sub(i,i) -- get character
        love.graphics.draw(self.letters[c], x + (i - 1) * 8, y) -- draw character
    end
end

function Font:printToCanvas(text, w, h, mode) -- multiline print
    local canvas = love.graphics.newCanvas(w, h) -- create local canvas
    love.graphics.setCanvas(canvas) -- set canvas

    -- TESTING START
    if temp then
        love.graphics.setColor(1, 0, 0, 1)
        love.graphics.rectangle('fill', 0, 0, w, h)
        love.graphics.setColor(1, 1, 1, 1)
    end
    -- TESTING END

    local textList = {} -- list of lines
    local oldLine = '' -- old line state
    local newLine = '' -- new line state
    local oldText = '' -- old text state
    local lineLength = (#text * 8) - 8 -- calculate line length
    local innerLineLength = 0 -- set inner line length

    if h < 22 then -- if single line
        if lineLength - w > -4 then -- if text longer than width - clearance
            while lineLength - w > - 18 do -- while text longer
                text = text:sub(0, #text - 1) -- remove last character
                lineLength = (#text * 8) - 8 -- calculate line length
            end
            text = text..'~' -- append ellipses to end
        end
        textList[#textList + 1] = text -- add to list of lines
    elseif lineLength < w then -- if text less than width
        if lineLength - w > -4 then -- if text longer than width - clearance
            while lineLength - w > - 18 do -- while text longer
                text = text:sub(0, #text - 1) -- remove last character
                lineLength = (#text * 8) - 8 -- calculate line length
            end
            text = text..'~' -- append ellipses to end
        end
        textList[#textList + 1] = text -- add to list of lines
    else
        while lineLength >= w do -- while text longer than width
            if ((#textList + 2) * 12) - 2 > h then -- I genuinely don't know what this inequality does
                if lineLength - w > -4 then -- if text longer than width - clearance
                    while lineLength - w > - 18 do -- while text longer
                        text = text:sub(0, #text - 1) -- remove last character
                        lineLength = (#text * 8) - 8 -- calculate line length
                    end
                    text = text..'~' -- append ellipses to end
                end
                textList[#textList + 1] = text -- add to list of lines
                lineLength = 0 -- reset lineLength
            else
                oldLine = '' -- reset oldLine
                newLine = '' -- reset newLine
                oldText = '' -- reset oldText
                innerLineLength = 0 -- reset innerLineLength
                while innerLineLength < w do -- while new line length is less than canvas width
                    split = string.find(text, ' ') -- split on first space
                    oldLine = newLine -- save newLine as oldLine
                    if split == nil then -- if no spaces
                        oldText = text -- set oldText as all remaining text
                        break
                    end
                    newLine = newLine..text:sub(0, split - 1)..' ' -- next word is added to newLine
                    oldText = text -- set oldText as all remaining text
                    text = text:sub(split + 1, #text) -- set text as text without next word
                    innerLineLength = (#newLine * 8) - 8 -- recalcuate innerLineLength
                end

                textList[#textList + 1] = oldLine:sub(0, #oldLine - 1) -- add to list of lines
                text = oldText -- set text to oldText
                lineLength = (#text * 8) -- recalculate lineLength
            end
        end
        if lineLength ~= 0 then -- remaining text
            if lineLength - w > -4 then -- if text longer than width - clearance
                while lineLength - w > - 18 do -- while text longer
                    text = text:sub(0, #text - 1) -- remove last character
                    lineLength = (#text * 8) - 8 -- calculate lineLength
                end
                text = text..'~' -- append ellipses to end
            end
            textList[#textList + 1] =  text -- add to list of lines
        end
    end

    for index, line in pairs(textList) do -- for each line
        lineLength = (#line * 8) - 2  -- calculate lineLength

        if mode == 'left' then -- if left aligned
            local off = 0 -- set left offset to 0
            for i = 1, #line do -- for each character in line
                local c = line:sub(i,i) -- get character
                love.graphics.draw(self.letters[c], off + (i - 1) * 8, (index - 1) * 12) -- draw character
            end
        elseif mode == 'center' then -- if center aligned
            local off = math.max(math.floor((w - lineLength) / 2), 0) -- calculate left offset to center line
            for i = 1, #line do -- for each character in line
                local c = line:sub(i,i) -- get character
                love.graphics.draw(self.letters[c], off + (i - 1) * 8, (index - 1) * 12) -- draw character
            end
        elseif mode == 'right' then -- if right aligned
            local off = math.max((w - lineLength), 0) -- calcuate left offset to right alingn line
            for i = 1, #line do -- for character in line
                local c = line:sub(i,i) -- get character
                love.graphics.draw(self.letters[c], off + (i - 1) * 8, (index - 1) * 12) -- draw character
            end
        end
    end

    love.graphics.setCanvas() -- reset canvas
    
    return canvas
end
