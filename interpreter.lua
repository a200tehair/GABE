-- WELCOME TO THE GABE SCRIPT!
-- you shouldn't program in this

local file = io.open(arg[1], "r")

local bt = {}

local data = file:read("a")

local ptr = 1

local i = 1
repeat
    local char = data:sub(i, i)
    i = i + 1
    if char == "R" then
        ptr = ptr + 1
    elseif char == "A" then
        if bt[ptr] == nil then
            bt[ptr] = 0
        end
        bt[ptr] = (bt[ptr] + 1) % 256
    elseif char == "E" then
        goto skip
    end
until i > data:len()
print("NoE")
goto fin
::skip::

local register = {}
local markers = {}

local compflag = false

local r = 1
if #bt == 0 then
    print("No code found")
    goto fin
end
while r <= #bt do

    if bt[r] == 0 then
        goto continue
    elseif bt[r] == 1 then -- define a var
        local reg = bt[r + 1]
        local num = bt[r + 2]

        if register[reg] ~= nil then print("AaR") goto fin end
        register[reg] = num
        r = r + 3
    elseif bt[r] == 2 then -- remove a var
        local reg = bt[r + 1]

        if register[reg] == nil then print("NaR") goto fin end
        table.remove(bt, reg)
        r = r + 2
    elseif bt[r] == 3 then -- add to a var
        local reg = bt[r + 1]
        local amt = bt[r + 2]

        if register[reg] == nil then print("NaR") goto fin end
        register[reg] = register[reg] + amt
        r = r + 3
    elseif bt[r] == 4 then -- remove from a var
        local reg = bt[r + 1]
        local amt = bt[r + 2]

        if register[reg] == nil then print("NaR") goto fin end
        register[reg] = register[reg] - amt
        r = r + 3
    elseif bt[r] == 5 then -- marker
        markers[#markers+1] = r
        r = r + 1
    elseif bt[r] == 6 then -- jmp instruction
        local mrk = bt[r + 1]
        if markers[mrk] == nil then print("NaM") goto fin end

        r = markers[mrk]
    elseif bt[r] == 7 then -- cmp instruction
        local arg1 = bt[r + 1]
        local arg2 = bt[r + 2]

        local narg1 = register[arg1]
        local narg2 = register[arg2]

        if narg1 == nil or narg2 == nil then print("NaR") goto fin end

        if narg1 > narg2 then
            compflag = true
        else
            compflag = false
        end
        r = r + 3
    elseif bt[r] == 8 then -- branch if compflag / bcp
        local mrk = bt[r + 1]
        if markers[mrk] == nil then print("NaM") goto fin end

        if compflag == true then
            r = markers[mrk]
        else
            r = r + 2
        end
    elseif bt[r] == 9 then -- branch if not compflag / ncp
        local mrk = bt[r + 1]
        if markers[mrk] == nil then print("NaM") goto fin end

        if compflag == false then
            r = markers[mrk]
        else
            r = r + 2
        end
    elseif bt[r] == 10 then -- cie
        local arg1 = bt[r + 1]
        local arg2 = bt[r + 2]

        local narg1 = register[arg1]
        local narg2 = register[arg2]

        if narg1 == nil or narg2 == nil then print("NaR") goto fin end

        if narg1 >= narg2 then
            compflag = true
        else
            compflag = false
        end
        r = r + 3
    elseif bt[r] == 11 then -- ceq
        local arg1 = bt[r + 1]
        local arg2 = bt[r + 2]

        local narg1 = register[arg1]
        local narg2 = register[arg2]

        if narg1 == nil or narg2 == nil then print("NaR") goto fin end

        if narg1 == narg2 then
            compflag = true
        else
            compflag = false
        end
        r = r + 3
    elseif bt[r] == 12 then -- rmm
        local arg1 = bt[r + 1]

        if markers[arg1] == nil then print("NaM") goto fin end
        table.remove(markers, arg1)
        r = r + 2
    elseif bt[r] == 13 then -- out
        local num = bt[r + 1]

        if register[num] == nil then print("NaR") goto fin end
        io.write(tostring(register[num]))
        r = r + 2
    elseif bt[r] == 14 then -- oas, ascii out
        local num = bt[r + 1]

        if register[num] == nil then print("NaR") goto fin end
        io.write(string.char(register[num]))
        r = r + 2
    elseif bt[r] == 15 then -- usr input
        local num = bt[r + 1]

        if register[num] ~= nil then print("AaR") goto fin end
        local set = io.read(1)

        if set == nil then print("NaC") goto fin end
        register[num] = string.byte(set)
        r = r + 2
    else
        r = r + 1
    end

    ::continue::
end

::fin::