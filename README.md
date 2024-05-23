# rime-091
用于Rime的091五笔方案

## 特性

- 4码自动上屏
- 4码后空码顶屏（若无候选则清屏）
- 可使用全拼反查
- z键可重复历史上屏
- z键可以模糊匹配
- 支持如下快捷命令，使用方法参考 `wubi091.dict.yaml`
```lua
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
```
- 支持输入当前时间、日期、星期等