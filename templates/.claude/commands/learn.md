# /learn - 提取可复用模式

分析当前会话并提取任何值得保存为技能的模式。

## 触发条件

当你在会话中解决了一个非主要问题时，随时运行 `/learn`。

## 提取内容

寻找：

1. **错误解决模式**
   - 发生了什么错误？
   - 根本原因是什么？
   - 怎么修复的？
   - 这对类似错误是否可复用？

2. **调试技巧**
   - 那些不明显的调试步骤
   - 起作用的工具组合
   - 诊断模式

3. **变通方案 (Workarounds)**
   - 库的怪癖
   - API 限制
   - 特定版本的修复

4. **项目特定模式**
   - 发现的代码库约定
   - 做出的架构决策
   - 集成模式

## 输出格式

在 `~/.claude/skills/learned/[pattern-name].md` 创建技能文件：

```markdown
# [Descriptive Pattern Name] ([描述性模式名称])

**Extracted:** [Date] (**提取日期:** [日期])
**Context:** [Brief description of when this applies] (**上下文:** [适用情况简介])

## Problem (问题)
[What problem this solves - be specific] ([这也解决了什么问题 - 具体说明])

## Solution (解决方案)
[The pattern/technique/workaround] ([模式/技巧/变通方案])

## Example (示例)
[Code example if applicable] ([代码示例，如果适用])

## When to Use (何时使用)
[Trigger conditions - what should activate this skill] ([触发条件 - 什么应该激活此技能])
```

## 流程

1. 审查会话以查找可提取的模式
2. 识别最有价值/可复用的见解
3. 起草技能文件
4. 保存前请用户确认
5. 保存到 `~/.claude/skills/learned/`

## 注意事项

- 不要提取微不足道的修复（拼写错误、简单的语法错误）
- 不要提取一次性问题（特定 API 中断等）
- 专注于能为未来会话节省时间的模式
- 保持技能专注 - 每个技能一个模式
