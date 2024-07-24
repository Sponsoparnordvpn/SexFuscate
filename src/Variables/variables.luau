local Variables = {}
local GeneratedNames = {

}
Variables.GenName = function()
    if Obfuscator.Settings.StringEncode == "confusion" then
        local name = Obfuscator.Settings.Prefix
        local choices = {"1", "I", "l"}
        for i = 1, 15 do
            local choice = math.random(1, #choices)
            name = name .. choices[choice]
        end
        if table.find(GeneratedNames, name) then
            return Variables.GenName()
        else
            table.insert(GeneratedNames, name)
            return name
        end
    else
        local char = string.lower(string.char(math.random(string.byte('A'), string.byte('Z'))))
        if table.find(GeneratedNames, char) then
            char = char..tostring(#GeneratedNames)
            table.insert(GeneratedNames, char)
            return char
        else
            table.insert(GeneratedNames, char)
            return char
        end
    end
end

Variables.Encrypt = function(var, type, key)
    if type == "bytes" then
        local encoded = "\""
        for i = 1, #var do
            local charCode = string.byte(var, i)
            encoded = encoded .. "\\" .. charCode
        end
        encoded = encoded .. "\""
        return encoded
    elseif type == "zalgo" then
        local zalgo_up = {"\204\128", "\204\130", "\204\131", "\204\132", "\204\134", "\204\136", "\204\137", "\204\138", "\204\139", "\204\140", "\204\141", "\204\142", "\204\143", "\204\145", "\204\147", "\204\148", "\204\149", "\204\150", "\204\151", "\204\152", "\204\153", "\204\154", "\204\155", "\204\156", "\204\157", "\204\158", "\204\159", "\204\160", "\204\162", "\204\163", "\204\164", "\204\165", "\204\167", "\204\168", "\204\169", "\204\170", "\204\171", "\204\172", "\204\173", "\204\174", "\204\175", "\204\176", "\204\178", "\204\179", "\204\180", "\204\181", "\204\182", "\204\183", "\204\184", "\204\185", "\204\186", "\204\187", "\204\188", "\204\189", "\204\190", "\204\191", "\205\128", "\205\130", "\205\131", "\205\132", "\205\133", "\205\135", "\205\136", "\205\137", "\205\138", "\205\139", "\205\140", "\205\141", "\205\142", "\205\143", "\205\144", "\205\145", "\205\146", "\205\147", "\205\148", "\205\149", "\205\150", "\205\151", "\205\152", "\205\153", "\205\154", "\205\155", "\205\156", "\205\157", "\205\158", "\205\159", "\205\160", "\205\161", "\205\162", "\205\163", "\205\164", "\205\165", "\205\166", "\205\167", "\205\168", "\205\169", "\205\170", "\205\171", "\205\172", "\205\173", "\205\174", "\205\175", "\205\176", "\205\177", "\205\178", "\205\179", "\205\180", "\205\181", "\205\182", "\205\183", "\205\184", "\205\185", "\205\186", "\205\187", "\205\188", "\205\189", "\205\190", "\205\191"}
        local zalgo_down = {"\204\130", "\204\132", "\204\133", "\204\134", "\204\136", "\204\137", "\204\138", "\204\139", "\204\140", "\204\141", "\204\142", "\204\143", "\204\144", "\204\145", "\204\146", "\204\147", "\204\148", "\204\149", "\204\150", "\204\151", "\204\152", "\204\153", "\204\154", "\204\155", "\204\156", "\204\157", "\204\158", "\204\159", "\204\160", "\204\161", "\204\162", "\204\163", "\204\164", "\204\165", "\204\166", "\204\167", "\204\168", "\204\169", "\204\170", "\204\171", "\204\172", "\204\173", "\204\174", "\204\175", "\204\176", "\204\177", "\204\178", "\204\179", "\204\180", "\204\181", "\204\182", "\204\183", "\204\184", "\204\185", "\204\186", "\204\187", "\204\188", "\204\189", "\204\190", "\204\191", "\205\128", "\205\129", "\205\130", "\205\131", "\205\132", "\205\133", "\205\134", "\205\135", "\205\136", "\205\137", "\205\138", "\205\139", "\205\140", "\205\141", "\205\142", "\205\143", "\205\144", "\205\145", "\205\146", "\205\147", "\205\148", "\205\149", "\205\150", "\205\151", "\205\152", "\205\153", "\205\154", "\205\155", "\205\156", "\205\157", "\205\158", "\205\159", "\205\160", "\205\161", "\205\162", "\205\163", "\205\164", "\205\165", "\205\166", "\205\167", "\205\168", "\205\169", "\205\170", "\205\171", "\205\172", "\205\173", "\205\174", "\205\175", "\205\176", "\205\177", "\205\178", "\205\179", "\205\180", "\205\181", "\205\182", "\205\183", "\205\184", "\205\185", "\205\186", "\205\187", "\205\188", "\205\189", "\205\190", "\205\191"}
        local zalgo_text = ""
        for i = 1, #var do
            local char = var:sub(i, i)
            zalgo_text = zalgo_text .. char
            for j = 1, math.random(1, 8) do
                zalgo_text = zalgo_text .. zalgo_up[math.random(1, #zalgo_up)]
            end
            for j = 1, math.random(1, 8) do
                zalgo_text = zalgo_text .. zalgo_down[math.random(1, #zalgo_down)]
            end
        end
        return zalgo_text
    else
        local textBytes = {string.byte(var, 1, #var)}
        local keyBytes = {string.byte(key, 1, #key)}
        local cipherBytes = {}

        for i=1, #textBytes do
            local keyByte = keyBytes[(i - 1) % #keyBytes + 1]
            table.insert(cipherBytes, bit32.bxor(textBytes[i], keyByte))
        end
        local encoded = "\""
        for i = 1, #var do
            local charCode = string.byte(string.char(unpack(cipherBytes)), i)
            encoded = encoded .. "\\" .. charCode
        end
        encoded = encoded .. "\""
        return encoded
    end
end


Variables.Decrypt = function(encodedString, type)
    if type == "bytes" then
        local decoded = ""
        local pattern = "\\(%d+)"
        local index = 1
        while index <= #encodedString do
            local start, finish, byteStr = encodedString:find(pattern, index)
            if not start then
                break
            end
            local byteCode = tonumber(byteStr)
            decoded = decoded .. string.char(byteCode)
            index = finish + 1
        end
        return decoded
    else
        return encodedString
    end
end


return Variables