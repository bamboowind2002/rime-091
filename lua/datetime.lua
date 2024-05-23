

local function init(env)
    env.engine.context.commit_notifier:connect(function (ctx) 
        local cand = ctx:get_selected_candidate()
        if not cand then
            return
        end
        if cand.type ~= "cmd" then
            return
        end
        --log.error(cand.comment)
        if cand.comment == "[计算器]" then
            os.execute("start calc.exe")
        elseif cand.comment == "[命令提示符]" then
            os.execute("start cmd.exe")
        elseif cand.comment == "[控制面板]" then
            os.execute("start control.exe")
        elseif cand.comment == "[用户目录]" then
            os.execute("start explorer.exe " .. rime_api.get_user_data_dir())
        elseif cand.comment == "[打开Excel]" then
            os.execute("start excel.exe")
        elseif cand.comment == "[画图]" then
            os.execute("start mspaint.exe")
        elseif cand.comment == "[记事本]" then
            os.execute("start notepad.exe")
        elseif cand.comment == "[屏幕键盘]" then
            os.execute("start osk.exe")
        elseif cand.comment == "[打开PPT]" then
            os.execute("start powerpnt.exe")
        elseif cand.comment == "[设备管理器]" then
            os.execute("start devmgmt.msc")
        elseif cand.comment == "[打开Word]" then
            os.execute("start winword.exe")
        elseif cand.comment == "[注册表]" then
            os.execute("start regedit.exe")
        end
    end) 
end


local function filter(input, env)
    for cand in input:iter() do
        -- log.error(cand.text)
        if cand.text == "$y年$m月$d日 $W $0h:$0mi:$0s" then
            -- log.error("正确进入")
            local week = tonumber(os.date("%w"))
            local lookup = {
                [0]="日",
                [1]="一",
                [2]="二",
                [3]="三",
                [4]="四",
                [5]="五",
                [6]="六"
            }
            local str = lookup[week]
            yield(Candidate("date", cand.start, cand._end, os.date("%Y年%m月%d日 星期".. str .. " %H:%M:%S"), ""))
        elseif cand.text == "$W" then
            local week = tonumber(os.date("%w"))
            local lookup = {
                [0]="日",
                [1]="一",
                [2]="二",
                [3]="三",
                [4]="四",
                [5]="五",
                [6]="六"
            }
            local str = lookup[week]
            yield(Candidate("date", cand.start, cand._end, "星期".. str, ""))
        elseif cand.text == "$w" then
            local week = tonumber(os.date("%w"))
            local lookup = {
                [0]="Sunday",
                [1]="Monday",
                [2]="Tuesday",
                [3]="Wednesday",
                [4]="Thursday",
                [5]="Friday",
                [6]="Saturday"
            }
            local str = lookup[week]
            yield(Candidate("date", cand.start, cand._end, str, ""))
        elseif cand.text == "$y年$m月$d日" then
            yield(Candidate("date", cand.start, cand._end, os.date("%Y年%m月%d日"), ""))
        elseif cand.text == "$0h:$0mi:$0s" then
            yield(Candidate("date", cand.start, cand._end, os.date("%H:%M:%S"), ""))
        elseif cand.text == "$X[计算器]calc" then
            yield(Candidate("cmd", cand.start, cand._end, "", "[计算器]"))
        elseif cand.text == "$X[命令提示符]cmd" then
            yield(Candidate("cmd", cand.start, cand._end, "", "[命令提示符]"))
        elseif cand.text == "$X[控制面板]control.exe" then
            yield(Candidate("cmd", cand.start, cand._end, "", "[控制面板]"))
        elseif cand.text == "$X[极点目录]%freeime%" then
            yield(Candidate("cmd", cand.start, cand._end, "", "[用户目录]"))
        elseif cand.text == "$X[打开Excel]excel" then
            yield(Candidate("cmd", cand.start, cand._end, "", "[打开Excel]"))
        elseif cand.text == "$X[画图]mspaint" then
            yield(Candidate("cmd", cand.start, cand._end, "", "[画图]"))
        elseif cand.text == "$X[记事本]notepad" then
            yield(Candidate("cmd", cand.start, cand._end, "", "[记事本]"))
        elseif cand.text == "$X[屏幕键盘]osk" then
            yield(Candidate("cmd", cand.start, cand._end, "", "[屏幕键盘]"))
        elseif cand.text == "$X[打开PPT]powerpnt" then
            yield(Candidate("cmd", cand.start, cand._end, "", "[打开PPT]"))
        elseif cand.text == "$X[设备管理器]devmgmt.msc" then
            yield(Candidate("cmd", cand.start, cand._end, "", "[设备管理器]"))
        elseif cand.text == "$X[打开Word]winword" then
            yield(Candidate("cmd", cand.start, cand._end, "", "[打开Word]"))
        elseif cand.text == "$X[注册表]regedit" then
            yield(Candidate("cmd", cand.start, cand._end, "", "[注册表]"))
        else
            yield(cand)
        end
    end
end

return {init = init, func = filter}