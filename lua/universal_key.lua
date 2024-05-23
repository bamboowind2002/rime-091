
local function init(env)
    env.mem = Memory(env.engine, env.engine.schema)
end

local function dfs(now_str, last, u, len, seg, env)
    -- log.error(now_str)
    if u == len + 1 then
        env.mem:dict_lookup(now_str, false, 1024)
        for entry in env.mem:iter_dict() do
            if last ~= now_str then
                yield(Candidate("universal", seg.start, seg._end, entry.text, ""))
            end
        end
        return
    end
    if last:sub(u, u) == 'z' then
        for i = 97, 122 do
            dfs(now_str .. string.char(i), last, u + 1, len, seg, env)
        end
    else
        dfs(now_str .. last:sub(u, u), last, u + 1, len, seg, env)
    end
end

local function translator(input, seg, env)
    
    -- log.error("测试")

    
    local flag = false
    -- log.error("循环")
    for i = 1, string.len(input) do
        if input:sub(i, i) == 'z' then
            flag = true
            break
        end
    end

    if flag then
        dfs("", input, 1, string.len(input), seg, env)
    end
end

return {init = init, func = translator}