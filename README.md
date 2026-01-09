# 091五笔

## 简介
作者「行走的风景」，码表源自「晓览」维护的「点儿词库」。该仓库主要是模拟部分极点五笔的输入特性。

## 特性
- 4码及以上空码顶屏。修改 `auto_clear.lua` 中的 `ding_length` 可以更改开始顶屏的码长。
- 大写字母顶屏+直出。
- 4码唯一不自动上屏。若要配置4码唯一自动上屏可配置 `wubi091.schema.yaml` 中的 `speller` 项，主要修改 `auto_select` 和 `auto_select_pattern` 项进行配置。
- Ctrl+T 快捷键简入繁出
- Tab 键清空编码
- Enter 键上屏编码
- 更多快捷键可在 `wubi091.schema.yaml` 中的 `key_binder/bindings` 中自行配置
- z键通配符
- z键历史
- \`键反查，反查可在 `wubi091.schema.yaml` 中的 `reverse_lookup` 选项中配置。本仓库不包含反查方案的字典。
- 支持换行词条，换行用\n表示
- 支持日期，使用方法类似极点五笔，具体见词典文件中的相关词条。

## 安装
可使用本仓库的`dist`分支进行安装。本仓库只包含词库文件和方案文件，若要在各个rime前端使用，还需在 `default.yaml` 或 `default.custom.yaml` 的 `schema_list` 配置选项中，添加本方案。本方案的 `schema_id` 是 `wubi091`。

### Plum
可使用「东风破」安装。具体使用方法详见 https://github.com/rime/plum
```bash
bash rime-install bamboowind2002/rime-091@dist
```

## 修改词库

使用本仓库的`master`分支。
可修改 `base.txt` 的内容（极点导出的txt词库），然后运行 `make_dist.sh` 自动生成rime方案。生成路径为 `dist` 目录。
生僻字的内容在 `attach.txt` 中。