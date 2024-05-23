local ding_length = 4

local function init(env)
    env.mem = Memory(env.engine, env.engine.schema)
end

-- 当有候选时，顶上屏，无候选时，清空编码
local function ding_ping(env)
    if env.engine.context:has_menu() then
        env.engine.context:commit()
    else
        env.engine.context:clear()
    end
end


local function processor(key_event, env)
    -- 过滤掉释放键
    if key_event:release() then
        return 2
    end
    -- 过滤掉ctrl alt super
    if key_event:ctrl() or key_event:alt() or key_event:super() then
        return 2
    end

    if key_event.keycode == 32 then
        if env.engine.context:has_menu() then
            env.engine.context:commit()
            return 1
        elseif env.engine.context:is_composing() then
            env.engine.context:clear()
            return 1
        else
            return 2
        end
    end

    -- 大写字母直接顶屏并上屏
    if key_event.keycode >= 65 and key_event.keycode <= 90 then
        ding_ping(env)
        env.engine:commit_text(string.char(key_event.keycode))
        return 1
    end

    -- 小写字母正常顶屏
    if key_event.keycode >= 97 and key_event.keycode <= 122 then
        -- 没到顶屏码长
        if string.len(env.engine.context.input) < ding_length then
            return 2
        end

        -- 到顶屏码长，检测是否空码
        local input = env.engine.context.input .. string.char(key_event.keycode)
        local flag = false
        env.mem:dict_lookup(input, true, 1)
        for entry in env.mem:iter_dict() do
            flag = true
        end

        -- 不是空码，什么也不做
        if flag then
            return 2
        end

        -- 是空码，顶屏
        ding_ping(env)

        return 2
    end

    return 2
end

return {init = init, func = processor}