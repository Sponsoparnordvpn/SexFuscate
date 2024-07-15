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


return Lexer