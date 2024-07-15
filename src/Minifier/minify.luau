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

return Minifier