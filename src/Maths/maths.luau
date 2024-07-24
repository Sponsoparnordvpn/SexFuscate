local Maths = {}
local mappings = {}
math.randomseed(os.time() + math.random(1000000))

Maths.OP = function(y, fl)
    if type(y) ~= "number" then
        y = tonumber(y)
    end
    if not fl then
        fl = "math.floor"
    end
    local function is_integer(n)
        return type(n) == "number" and n == math.floor(n)
    end

    if is_integer(y) and y ~= 0 and y ~= 1 then
        if mappings[y] then
            return mappings[y]
        end

        local a = math.random(1, y+100)
        local b = math.random(1, y+100)
        local c = math.random(1, y+100)
        local d = math.random(1, y+100)
        local e = math.random(1, y+100)

        local numerator = a * y^4 - b * y^3 + c * y^2 - d * y + e
        local denominator = a * y^3 - b * y^2 + c * y - d
        
        if denominator == 0 then
            denominator = 1
        end
        
        local expression = string.format("%s((%d * %d^4 - %d * %d^3 + %d * %d^2 - %d * %d + %d) / (%d * %d^3 - %d * %d^2 + %d * %d - %d))",fl, a, y, b, y, c, y, d, y, e, a, y, b, y, c, y, d)
        
        mappings[y] = expression
        return expression
    else
        if y == 0  then
            return string.format("0*%d", math.random(1, 65000))
        else
            return string.format("%s-%s+%s", y, y, y)
        end
    end
end


return Maths