# 智能体编排

## 可用智能体

位于 `~/.claude/agents/`：

| 智能体 | 用途 | 适用场景 |
|-------|---------|-------------|
| planner | 实现规划 | 复杂特性开发，重构 |
| architect | 系统设计 | 架构决策 |
| tdd-guide | 测试驱动开发 | 新特性开发，Bug 修复 |
| code-reviewer | 代码审查 | 代码编写完成后 |
| security-reviewer | 安全分析 | 提交代码前 |
| build-error-resolver | 修复构建错误 | 构建失败时 |
| e2e-runner | 端到端 (E2E) 测试 | 关键用户流程验证 |
| refactor-cleaner | 死代码清理 | 代码维护 |
| doc-updater | 文档工作 | 更新文档 |

## 即时智能体调用

以下情况无需用户提示，应直接调用：
1. 复杂特性请求 - 使用 **planner** (规划师) 智能体
2. 代码刚编写/修改完 - 使用 **code-reviewer** (代码审查者) 智能体
3. Bug 修复或新特性 - 使用 **tdd-guide** (TDD向导) 智能体
4. 架构决策 - 使用 **architect** (架构师) 智能体

## 并行任务执行

对于独立的操作，**务必**使用并行任务执行：

```markdown
# 推荐：并行执行
同时启动 3 个智能体：
1. 智能体 1：分析 auth.ts 的安全性
2. 智能体 2：审查缓存系统的性能
3. 智能体 3：检查 utils.ts 的类型

# 避免：不必要的串行
先运行智能体 1，然后智能体 2，最后智能体 3
```

## 多视角分析

针对复杂问题，使用分角色的子智能体进行分析：
- 事实核查员 (Factual reviewer)
- 高级工程师 (Senior engineer)
- 安全专家 (Security expert)
- 一致性审查员 (Consistency reviewer)
- 冗余检查员 (Redundancy checker)
