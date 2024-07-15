local Serializer = {}

function Serializer:Serialize(LexedArray)
    local src = {}

    for _, token in ipairs(LexedArray) do
        table.insert(src, token.raw)
    end

    return table.concat(src)
end

return Serializer