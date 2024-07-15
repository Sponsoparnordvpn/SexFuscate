function xor(text, key)
    local textBytes = {string.byte(text, 1, #text)}
    local keyBytes = {string.byte(key, 1, #key)}
    local cipherBytes = {}

    for i=1, #textBytes do
        local keyByte = keyBytes[(i - 1) % #keyBytes + 1]
        table.insert(cipherBytes, bit32.bxor(textBytes[i], keyByte))
    end

    return string.char(unpack(cipherBytes))
end