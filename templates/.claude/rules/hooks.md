# Hooks 系统

## Hook 类型

- **PreToolUse**：工具执行前 (验证、参数修改)
- **PostToolUse**：工具执行后 (自动格式化、检查)
- **Stop**：会话结束时 (最终验证)

## 当前 Hooks (位于 ~/.claude/settings.json)

### PreToolUse
- **tmux 提醒**：针对长时间运行的命令 (npm, pnpm, yarn, cargo 等) 建议使用 tmux
- **git push 审查**：Push 前打开 Zed 进行审查
- **文档拦截器**：阻止创建不必要的 .md/.txt 文件

### PostToolUse
- **PR 创建**：记录 PR URL 和 GitHub Actions 状态
- **Prettier**：编辑后自动格式化 JS/TS 文件
- **TypeScript 检查**：编辑 .ts/.tsx 文件后运行 tsc
- **console.log 警告**：警告已编辑文件中的 console.log

### Stop
- **console.log 审计**：会话结束前检查所有修改过的文件是否存在 console.log

## 自动授权

谨慎使用：
- 对受信任且定义明确的计划启用
- 对探索性工作禁用
- 永不使用 dangerously-skip-permissions 标志
- 推荐在 `~/.claude.json` 中配置 `allowedTools`

## TodoWrite 最佳实践

使用 TodoWrite 工具以：
- 追踪多步骤任务的进度
- 验证对指令的理解
- 实现实时导向
- 展示细粒度的实现步骤

Todo 列表能揭示：
- 顺序混乱的步骤
- 遗漏的事项
- 额外不必要的事项
- 错误的粒度
- 被误解的需求
