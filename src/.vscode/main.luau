--[[
Unfortunately, Luau does not support package.path. The folders are likely created if you want to view the source.
WARNING: This source is not intended to be modified.
WARNING: For any questions, please contact me on my Discord [Link in my GitHub profile].
DISCLAIMER: You can use this, but please give credit 🙏
--]]

local _VERSION = "1.0.0"
local Obfuscator = {}

Obfuscator.Settings = {
    ["Watermark"] = string.format("This file was sexified by SexFuscator | %s", _VERSION),
    ["Prefix"] = "_SEX", -- Your variable prefix, e.g., _SEX -> _SEXIlIIl11IllI1IlI
    ["ComplexifyMaths"] = true, -- Complexify the algorithms
    ["EncodingAlgorithm"] = "zalgo", -- If EncodeStrings is false, then it's not necessary; OPTIONS: bytes/xor/zalgo
    ["EncodeStrings"] = true, -- Encode strings using the specified algorithm
    ["RandomOutputs"] = true, -- Generate random outputs to obfuscate
    ["ShortOutputs"] = true, -- Use short outputs to minimize code size
}



local Minifier = {}

function Minifier:remove_comments(src)
    src = src:gsub("%-%-.-\n", "\n")
    src = src:gsub("%-%-%[%[.-%]%]", "")
    return src
end

function Minifier:remove_whitespace(src)
     src = src:gsub("^%s+", ""):gsub("%s+$", "")
     src = src:gsub("%s+", " ")
     src = src:gsub("%s*([=+%-*/%^#<>~])%s*", "%1")
     src = src:gsub("%s*([,;{}()])%s*", "%1")
     src = src:gsub("\n+", "\n")
    return src
end

function Minifier:Minify(src, comments)
    if comments then
        src = Minifier:remove_comments(src)
    end
    src = Minifier:remove_whitespace(src)
    return src
end


local Serializer = {}

function Serializer:Serialize(LexedArray)
    local src = {}

    for _, token in ipairs(LexedArray) do
        table.insert(src, token.raw)
    end

    return table.concat(src)
end
local Lexer = {}
Lexer.Booleans = {
	["true"] = true,
	["false"] = true
}
Lexer.Globals = {
	["game"] = true,
	["workspace"] = true,
	["string"] = true,
	["math"] = true,
	["table"] = true,
	["script"] = true,
}


Lexer.Keywords = {
    ["local"] = true,
    ["if"] = true,
    ["for"] = true,
    ["then"] = true,
    ["end"] = true,
    ["do"] = true,
    ["while"] = true,
    ["repeat"] = true,
    ["until"] = true,
    ["nil"] = true,
    ["function"] = true,
    ["return"] = true
}
Lexer.Patterns = {
    {
        pattern = "^%[%[.-%]%]",
        name = "string"
    },
    {
        pattern = "^([\"']).-%1",
        name = "string"
    },
    {
        pattern = "^0x%w+",
        name = "hexadecimal"
    },
    {
        pattern = "^%d+%.%d+",
        name = "float"
    },
    {
        pattern = "^%d+",
        name = "int"
    },
    {
        pattern = "^[%a_][%w_]*%.[%a_][%w_]*",
        name = "tableaccess"
    },
    {
        pattern = "^[%a_][%w_]*%:[%a_][%w_]*",
        name = "methodcall"
    },
    {
        pattern = "^[%a_][%w_]*",
        name = "word"
    },
    {
        pattern = "^([%-%+/%*=])",
        name = "operator"
    },
    {
        pattern = "^%s+",
        name = "whitespace"
    },
    {
        pattern = "^.",
        name = "unknown"
    }
}
Lexer.Scan = function(lexed)
    for _, comp in pairs(lexed) do
        if comp.type == "word" then
            if Lexer.Keywords[comp.raw] then
                comp.type = "keyword"
            elseif Lexer.Globals[comp.raw] then
                comp.type = "global"
            elseif Lexer.Booleans[comp.raw] then
                comp.type = "bool"
            end
        elseif comp.type == "tableaccess" or comp.type == "methodcall" then
            local mainWord = string.match(comp.raw, "^[%a_][%w_]*")
            if Lexer.Globals[mainWord] then
                comp.type = "global"
            end
        end
    end
    
    return lexed
end


local function GetMatch(inputStr)
	for _, p in pairs(Lexer.Patterns) do
		local f1, f2 = string.find(inputStr, p.pattern)
		
		if f1 then
			local matches = string.match(inputStr, p.pattern)
			local raw = string.sub(inputStr, f1, f2)
			return {matches}, raw, p.name
		end
	end
	
	return nil
end

Lexer.Next = function(self)
    local remainingStr = string.sub(self.input, self.position, self.inputLen)
	local matches, raw, token = GetMatch(remainingStr)
	
	assert(matches, "Couldn't find any matches at position "..self.position)
	
	table.insert(self.result, {
		raw = raw,
		matches = matches,
		type = token
	})
	
	self.position += #raw
	
	if not (self.position > self.inputLen) then
		self:Next()
	end
end

Lexer.Parse = function(self,input)
	self.input = input
	self.position = 1
	self.inputLen = #input
	self.result = {}
	
	self:Next()
	
	self.result = self.Scan(self.result)
	
	return self.result
end

local Maths = {}
local mappings = {}
math.randomseed(os.time() + math.random(1000000))

Maths.OP = function(y)
    if type(y) ~= "number" then
        y = tonumber(y)
    end

    local function is_integer(n)
        return type(n) == "number" and n == math.floor(n)
    end

    if is_integer(y) and y ~= 0 then
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
        
        local expression = string.format("math.floor((%d * %d^4 - %d * %d^3 + %d * %d^2 - %d * %d + %d) / (%d * %d^3 - %d * %d^2 + %d * %d - %d))", a, y, b, y, c, y, d, y, e, a, y, b, y, c, y, d)
        
        mappings[y] = expression
        return expression
    else
        if y == 0 then
            return string.format("0*%d", math.random(1, 65000))
        else
            return string.format("%s-%s+%s", y, y, y)
        end
    end
end

local Variables = {}
local GeneratedNames = {
    "_SEX11I1l1IIIl111ll",
    "_SEXI11I1llII1llI1l",
    "_SEXlIlI11II1IIlIIl",
    "_SEX1ll1lI111llllI1",
    "_SEX1IIIIllIlll1lII",
    "_SEXII11Ill11lI1lll",
    "_SEXIIlll1III11IlII",
    "_SEXlII1II111I11ll1",
    "_SEXIl1111l1IIll111"
}

Variables.GenName = function()
    local name = Obfuscator.Settings.Prefix
    local choices = {"1", "I", "l"}
    for i = 1, 15 do
        local choice = math.random(1, #choices)
        name = name .. choices[choice]
    end
    if GeneratedNames[name] then
        return Variables.GenName()
    else
        GeneratedNames[name] = name
    end
    return name
end
Variables.Encrypt = function(var, type)
    if type == "bytes" then
        print(tostring(var))
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
        return var
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

local Breaker = {}
Breaker.BreakTable = function(input)
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




Obfuscator.Obfuscate = function(source)
    local start = os.clock()
    print("--------------------------------------------------")
    print(string.format("Welcome to SexFuscate | %s", _VERSION))
    print("Initializing variables...")
    
    local SRCContent = {}
    local ENV = {
        Functions = {},
        Locals = {},
        Tables = {}
    }
    
    local MathsCount = 0
    local StringsCount = 0
    local WordsCount = 0
    local GlobalsCount = 0
    
    for k, v in pairs(_G) do
        if type(v) == "table" then
            for x, func in pairs(v) do
                if type(func) == "function" then
                    if k == "_G" then
                        ENV.Functions[debug.info(func, "n")] = Variables.GenName()
                    else
                        ENV.Functions[k.."."..debug.info(func, "n")] = Variables.GenName()
                    end
                end
            end
        elseif type(v) == "function" then
            ENV.Functions[debug.info(v, "n")] = Variables.GenName()
        end
    end
    
    for k, v in pairs(_G) do
        if type(v) == "table" then
            ENV.Tables[k] = Variables.GenName()
        end
    end
    
    local SRCStack = "{{{}, {}, {}}}"
    print("Fetching your code...")
    
    if type(source) ~= "string" then
        print("[RoFuscate] Something went wrong : 'source' must be a string")
        return source
    end
    
    print("Setting up the obfuscation...")
    local LexedArray = Lexer:Parse(source)
    
    if type(LexedArray) ~= "table" then
        print("[RoFuscate] Something went wrong : Lexer is not able to parse 'source'")
        return source
    end
    
    local Serialized = Serializer:Serialize(LexedArray)
    local Minified = Minifier:Minify(Serialized, true)
    local MinifyLexed = Lexer:Parse(Minified)
    
    print("Parsing the code...")
    
    for k, v in pairs(MinifyLexed) do
        if v["type"] == "string" then
            if Obfuscator.Settings.EncodeStrings then
                StringsCount = StringsCount + 1
                local raw = v["raw"]:gsub("[\"']", "")
                if Obfuscator.Settings.EncodingAlgorithm == "zalgo" then
                    local zalgoed = Variables.Encrypt(raw, Obfuscator.Settings.EncodingAlgorithm)
                    v["raw"] = string.format("_SEXIIlll1III11IlII([[%s]])", zalgoed)
                else
                    v["raw"] = Variables.Encrypt(raw, Obfuscator.Settings.EncodingAlgorithm)
                end
            end
        elseif v["type"] == "int" then
            if Obfuscator.Settings.ComplexifyMaths then
                MathsCount = MathsCount + 1
                v["raw"] = Maths.OP(v["raw"])
            end
        elseif v["type"] == "word" then
            WordsCount = WordsCount + 1
            if not SRCContent[v["raw"]] then
                if not _G[v["raw"]] then
                    SRCContent[v["raw"]] = Variables.GenName()
                    v["raw"] = SRCContent[v["raw"]]
                else
                    if Obfuscator.Settings.ShortOutputs then
                        if _G[v["raw"]] then
                            ENV.Locals[v["raw"]] = Variables.GenName()
                            SRCContent[v["raw"]] = ENV.Locals[v["raw"]]
                            v["raw"] = ENV.Locals[v["raw"]]
                        else
                        end
                    else
                        if ENV.Functions[v["raw"]] then
                            v["raw"] = ENV.Functions[v["raw"]]
                        else
                            
                        end
                    end
                end
            else
                if Obfuscator.Settings.ShortOutputs then
                    if _G[v["raw"]] then
                        ENV.Locals[v["raw"]] = Variables.GenName()
                        SRCContent[v["raw"]] = ENV.Locals[v["raw"]]
                        v["raw"] = ENV.Locals[v["raw"]]
                    else
                    end
                else
                    if ENV.Functions[v["raw"]] then
                        v["raw"] = ENV.Functions[v["raw"]]
                    else
                        print("BOOOO")
                    end
                end
            end
        elseif v["type"] == "global" then
            GlobalsCount = GlobalsCount + 1
            local t, m = Breaker.BreakTable(tostring(v["raw"]))
            if t then
                if Obfuscator.Settings.ShortOutputs then
                    if _G[t] then
                        ENV.Locals[t] = Variables.GenName()
                        t = ENV.Locals[t]
                        v["raw"] = t.."."..m
                    end
                else
                    if ENV.Tables[t] then
                        if ENV.Functions[t.."."..m] then
                            v["raw"] = ENV.Functions[t.."."..m]
                        else
                            v["raw"] = ENV.Tables[t].."."..m
                        end
                    else
                        v["raw"] = t.."."..m
                    end
                end
            end
        elseif v["type"] == "tableaccess" then
            local S, Table, Method = Breaker.BreakTable(v["raw"])
            if Obfuscator.Settings.ShortOutputs and S then
                if _G[Table] then
                    ENV.Locals[Table] = Variables.GenName()
                    Table = ENV.Locals[Table]
                    v["raw"] = Table.."."..Method
                end
            elseif S then
                if ENV.Tables[Table] then
                    v["raw"] = Table.."."..Method
                end
            end
        end
    end
    
    print(string.format("Successfully obfuscated:\n%d Algorithms\n%d Strings\n%d Words\n%d Globals\nSerializing...", MathsCount, StringsCount, WordsCount, GlobalsCount))
    
    local n = Serializer:Serialize(MinifyLexed)
    local randomCode = [[
        print("HAHHAHAHAH SECURITY")
    ]] -- incomplete
    
    print("Formatting the code...")
    local ENVCode = ""
    
    if not Obfuscator.Settings.ShortOutputs then
        for k, v in pairs(ENV.Functions) do
            ENVCode = ENVCode .. string.format("local %s = %s;", v, k)
        end
        
        for k, v in pairs(ENV.Tables) do
            ENVCode = ENVCode .. string.format("local %s = %s;", v, k)
        end
    else
        for k, v in pairs(ENV.Locals) do
            ENVCode = ENVCode .. string.format("local %s = %s;", v, k)
        end
        
        for k, v in pairs(ENV.Tables) do
            ENVCode = ENVCode .. string.format("local %s = %s;", v, k)
        end
    end
    
    print("Obfuscating the code...")
    
    if Obfuscator.Settings.EncodingAlgorithm == "zalgo" and Obfuscator.Settings.EncodeStrings then
        local zalgo = Minifier:Minify([[
            local _SEX1IIIIllIlll1lII = {"\204\128","\204\130","\204\131","\204\132","\204\134","\204\136","\204\137","\204\138","\204\139","\204\140","\204\141","\204\142","\204\143","\204\145","\204\147","\204\148","\204\149","\204\150","\204\151","\204\152","\204\153","\204\154","\204\155","\204\156","\204\157","\204\158","\204\159","\204\160","\204\162","\204\163","\204\164","\204\165","\204\167","\204\168","\204\169","\204\170","\204\171","\204\172","\204\173","\204\174","\204\175","\204\176","\204\178","\204\179","\204\180","\204\181","\204\182","\204\183","\204\184","\204\185","\204\186","\204\187","\204\188","\204\189","\204\190","\204\191","\205\128","\205\130","\205\131","\205\132","\205\133","\205\135","\205\136","\205\137","\205\138","\205\139","\205\140","\205\141","\205\142","\205\143","\205\144","\205\145","\205\146","\205\147","\205\148","\205\149","\205\150","\205\151","\205\152","\205\153","\205\154","\205\155","\205\156","\205\157","\205\158","\205\159","\205\160","\205\161","\205\162","\205\163","\205\164","\205\165","\205\166","\205\167","\205\168","\205\169","\205\170","\205\171","\205\172","\205\173","\205\174","\205\175","\205\176","\205\177","\205\178","\205\179","\205\180","\205\181","\205\182","\205\183","\205\184","\205\185","\205\186","\205\187","\205\188","\205\189","\205\190","\205\191"}
            local function _SEX11I1l1IIIl111ll(_SEXI11I1llII1llI1l)
                local _SEXlIlI11II1IIlIIl = ""
                for i = 1, #_SEXI11I1llII1llI1l do
                    local _SEX1ll1lI111llllI1 = _SEXI11I1llII1llI1l:sub(i, i)
                    _SEXlIlI11II1IIlIIl = _SEXlIlI11II1IIlIIl .. _SEX1ll1lI111llllI1
                    for j = 1, math.random(1, 8) do
                        _SEXlIlI11II1IIlIIl = _SEXlIlI11II1IIlIIl .. _SEX1IIIIllIlll1lII[math.random(1, #_SEX1IIIIllIlll1lII)]
                    end
                    for j = 1, math.random(1, 8) do
                        _SEXlIlI11II1IIlIIl = _SEXlIlI11II1IIlIIl .. _SEX1IIIIllIlll1lII[math.random(1, #_SEX1IIIIllIlll1lII)]
                    end
                end
                return _SEXlIlI11II1IIlIIl
            end
            local function _SEXIIlll1III11IlII(_SEXlII1II111I11ll1)
                local _SEXIl1111l1IIll111 = ""
                for i = 1, #_SEXlII1II111I11ll1 do
                    local _SEXIlIIl11IllI1IlI = _SEXlII1II111I11ll1:sub(i, i)
                    if utf8.len(_SEXIlIIl11IllI1IlI) == 1 then
                        _SEXIl1111l1IIll111 = _SEXIl1111l1IIll111 .. _SEXIlIIl11IllI1IlI
                    end
                end
                return _SEXIl1111l1IIll111
            end;
        ]])
        
        n = string.format("return (function(...) do local sex = '%s' end do "..ENVCode..zalgo..n..";end do end end)(%s)", Obfuscator.Settings.Watermark, SRCStack)
    else
        n = string.format("return (function(...) do local sex = '%s' end do "..n.." end do end end)(%s)", Obfuscator.Settings.Watermark, SRCStack)
    end
    
    print(string.format("Obfuscation completed in %d seconds. Check the output !", os.clock() - start))
    print("--------------------------------------------------")
    return n
end




local source = [[
    local x;
    x = 5300
    print(x+2)
]]
print(Obfuscator.Obfuscate(source))
