# 用户级 CLAUDE.md 示例

这是用户级 CLAUDE.md 文件的示例。放置于 `~/.claude/CLAUDE.md`。

用户级配置全局应用于所有项目。用于：
- 个人编码偏好
- 你希望始终执行的通用规则
- 链接到你的模块化规则

---

## 核心理念

你是 Claude Code。我使用专门的智能体和技能来处理复杂任务。

**关键原则：**
1. **智能体优先 (Agent-First)**：将复杂工作委托给专门的智能体
2. **并行执行 (Parallel Execution)**：尽可能使用 Task 工具调用多个智能体
3. **谋定后动 (Plan Before Execute)**：对复杂操作使用计划模式
4. **测试驱动 (Test-Driven)**：实施前先编写测试
5. **安全第一 (Security-First)**：永不牺牲安全性

---

## 模块化规则

详细指南位于 `~/.claude/rules/`：

| 规则文件 | 内容 |
|-----------|----------|
| security.md | 安全检查，机密信息管理 |
| coding-style.md | 不可变性，文件组织，错误处理 |
| testing.md | TDD 工作流，80% 覆盖率要求 |
| git-workflow.md | 提交格式，PR 工作流 |
| agents.md | 智能体编排，何时使用哪个智能体 |
| patterns.md | API 响应，仓储模式 |
| performance.md | 模型选择，上下文管理 |

---

## 可用智能体

位于 `~/.claude/agents/`：

| 智能体 | 用途 |
|-------|---------|
| planner | 特性实施规划 |
| architect | 系统设计与架构 |
| tdd-guide | 测试驱动开发 |
| code-reviewer | 质量/安全代码审查 |
| security-reviewer | 安全漏洞分析 |
| build-error-resolver | 构建错误解决 |
| e2e-runner | Playwright E2E 测试 |
| refactor-cleaner | 死代码清理 |
| doc-updater | 文档更新 |

---

## 个人偏好

### 代码风格
- 代码、注释或文档中禁用 Emoji
- 倾向于不可变性 - 从不修改对象或数组
- 多小文件 > 少大文件
- 典型 200-400 行，最多 800 行

### Git
- 约定式提交：`feat:`, `fix:`, `refactor:`, `docs:`, `test:`
- 提交前始终本地测试
- 小而专注的提交

### 测试
- TDD：先写测试
- 最低 80% 覆盖率
- 关键流程的 Unit + Integration + E2E

---

## 编辑器集成

我使用 Zed 作为主编辑器：
- 用于文件跟踪的 Agent Panel
- CMD+Shift+R 打开命令面板
- 启用 Vim 模式

---

## 成功指标

当你满足以下条件时即为成功：
- 所有测试通过 (80%+ 覆盖率)
- 无安全漏洞
- 代码可读且可维护
- 满足用户需求

---

**理念**：智能体优先设计，并行执行，谋定后动，测而后码，安全为先。
