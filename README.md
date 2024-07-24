# SexFuscate 1.0.2
# SexFuscate 1.0.3

Welcome to SexFuscate, a Luau uglifier made in Luau.
To see the latest changelogs please check changelogs.luau
**WARNING: SexFuscate is a source-based obfuscator, which means that we do source-based obfuscation and not VM-based obfuscation.**

**Note:** I made this for learning purposes; feel free to use it to fit your needs!

## Introduction
SexFuscate is a tool designed to obfuscate Luau code by transforming the source code into a less readable format while maintaining its functionality. This can help in protecting your scripts from being easily read or modified by others.

## Installation
To install SexFuscate, simply clone the repository from GitHub and require it in your project.

```sh
git clone https://github.com/Sponsoparnordvpn/SexFuscate.git
```

## Usage
To run SexFuscate, please head up to .vscode/main.luau. You'll find the configuration here. Then scroll down at the bottom and you'll find the "source" variable, just put your code here.


## Example

In this example, I am obfuscating the following code with string encryption, algorithm encryption and short output mode

**[Input:](https://github.com/Sponsoparnordvpn/SexFuscate/input.luau)**
```lua
print([[Hello, world!]])
```
**[Output:](https://github.com/Sponsoparnordvpn/SexFuscate/output.luau)** 
```lua
return(function(...) do local sex = 'This file was sexified by SexFuscator | 1.0.0' end do local v81 = buffer.readu8;local o90 = buffer.writestring;local a120 = tostring;local o97 = buffer.readstring;local b112 = bit32.btest;local g84 = buffer.fromstring;local k58 = math.log10;local w = string.len;local k158 = table.insert;local m137 = pairs;local i174 = coroutine.isyieldable;local g127 = assert;local h129 = tonumber;local r110 = bit32.lshift;local y14 = string.unpack;local z62 = math.clamp;local b107 = bit32.rshift;local n68 = math.randomseed;local o93 = buffer.readi16;local g = buffer.readu32;local a = string.reverse;local w83 = buffer.writeu16;local b147 = loadstring;local j8 = string.pack;local j154 = table.freeze;local i78 = buffer.readi8;local g155 = table.clear;local y13 = string.byte;local r80 = buffer.copy;local k99 = bit32.band;local s = math.min;local f134 = print;local c63 = math.sinh;local d61 = math.abs;local c95 = buffer.len;local p102 = bit32.bor;local i101 = bit32.byteswap;local f105 = bit32.bxor;local o171 = coroutine.status;local y15 = string.rep;local i152 = table.sort;local w175 = ipairs;local o = string.sub;local u103 = bit32.bnot;local z = math.frexp;local m169 = coroutine.yield;local z115 = debug.info;local u162 = table.concat;local i64 = math.asin;local m = string.gmatch;local p42 = math.ldexp;local c108 = bit32.rrotate;local v135 = pcall;local y164 = table.find;local f136 = type;local g167 = coroutine.resume;local z100 = bit32.extract;local s91 = buffer.writei8;local y20 = os.clock;local r53 = math.pow;local k77 = buffer.tostring;local o165 = table.remove;local r67 = math.fmod;local f92 = buffer.writef32;local y59 = math.sign;local f49 = math.floor;local f124 = getfenv;local f151 = table.foreach;local m82 = buffer.writei16;local a170 = coroutine.close;local l128 = rawlen;local x109 = bit32.replace;local q = string.split;local b21 = os.difftime;local b52 = math.modf;local r43 = math.rad;local v98 = buffer.readf32;local r159 = table.create;local i150 = table.foreachi;local j = string.match;local j87 = buffer.writeu32;local m70 = math.ceil;local u89 = buffer.create;local y71 = math.sin;local c113 = bit32.countlz;local i149 = table.getn;local i = string.packsize;local z173 = coroutine.create;local u = string.char;local m119 = xpcall;local c75 = buffer.readf64;local s172 = coroutine.wrap;local w51 = math.sqrt;local q168 = coroutine.running;local l163 = table.clone;local i161 = table.isfrozen;local n36 = utf8.codes;local h160 = table.maxn;local j122 = typeof;local x157 = table.move;local h156 = table.pack;local v123 = require;local l121 = gcinfo;local v153 = table.unpack;local v = math.random;local i125 = setmetatable;local r126 = next;local j177 = newproxy;local a41 = math.log;local n86 = buffer.fill;local j56 = math.cos;local p54 = math.atan;local f39 = utf8.char;local z130 = rawequal;local b79 = buffer.readu16;local o69 = math.atan2;local p45 = math.round;local f132 = getmetatable;local y38 = utf8.len;local t148 = unpack;local d111 = bit32.lrotate;local o37 = utf8.codepoint;local r96 = buffer.writei32;local b6 = string.lower;local b = string.gsub;local j22 = os.time;local y = string.upper;local r94 = buffer.writef64;local e116 = debug.traceback;local k = math.cosh;local l = string.format;local e = math.noise;local q106 = bit32.arshift;local n88 = buffer.writeu8;local c104 = bit32.countrz;local m9 = string.find;local l50 = math.max;local i35 = utf8.offset;local e60 = math.acos;local f138 = select;local v48 = math.tanh;local h = buffer.readi32;local k146 = rawget;local o131 = collectgarbage;local c = math.tan;local s72 = math.exp;local v166 = setfenv;local o66 = math.deg;local x133 = rawset;local j176 = error;local f23 = os.date;local r182 = buffer;local m184 = debug;local d185 = _G;local x180 = utf8;local a179 = os;local n186 = table;local k181 = math;local y178 = string;local p187 = coroutine;local a183 = bit32; function s188(t189,q190)local z191="" local r192="\\(%d+)" local h193=1-1+1 while h193<=#t189 do local t194,b195,f196=t189:find(r192,h193)if not t194 then break end local i197=tonumber(f196)z191=z191 .. u(i197)h193=b195+1-1+1 end local h198={y13(z191,1-1+1,#z191)}local f199={y13(q190,1-1+1,#q190)}local e200={}for s201=1-1+1,#h198 do local j202=f199[(s201-1-1+1)%#f199+1-1+1] k158(e200,f105(h198[s201],j202))end local s188=u(unpack(e200))return s188 end f134(s188([["\60\0\31\24\4\73\14\27\23\31\16\75\68"]], 'testkey'));end do end end)({{{}, {}, {}}})
```


Thanks for reading
