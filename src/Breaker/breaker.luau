local Breaker = {}

Breaker.BreakTable = function(input)
    local var, method = input:match("([^:]+):([^:]+)")
    
    if var and method then
        return var, method
    end
    
    local parts = {}
    for part in input:gmatch("[^%.]+") do
        table.insert(parts, part)
    end
    
    local t, m = parts[1], parts[2]
    if t and m then
        return t, m
    else
        return input
    end
end

return Breaker