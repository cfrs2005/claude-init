# 贡献至 Everything Claude Code

感谢你想为本项目做出贡献。本仓库旨在成为 Claude Code 用户的社区资源。

## 我们期待的内容

### 智能体 (Agents)

能出色处理特定任务的新智能体：
- 特定语言的审查者 (Python, Go, Rust)
- 框架专家 (Django, Rails, Laravel, Spring)
- DevOps 专家 (Kubernetes, Terraform, CI/CD)
- 领域专家 (ML 管道, 数据工程, 移动端)

### 技能 (Skills)

工作流定义和领域知识：
- 语言最佳实践
- 框架模式
- 测试策略
- 架构指南
- 特定领域知识

### 指令 (Commands)

调用有用工作流的斜杠指令：
- 部署指令
- 测试指令
- 文档指令
- 代码生成指令

### 钩子 (Hooks)

有用的自动化：
- Linting/格式化钩子
- 安全检查
- 验证钩子
- 通知钩子

### 规则 (Rules)

必须始终遵循的准则：
- 安全规则
- 代码风格规则
- 测试要求
- 命名约定

### MCP 配置

新的或改进的 MCP 服务器配置：
- 数据库集成
- 云服务提供商 MCP
- 监控工具
- 通讯工具

---

## 如何贡献

### 1. Fork 仓库

```bash
git clone https://github.com/YOUR_USERNAME/everything-claude-code.git
cd everything-claude-code
```

### 2. 创建分支

```bash
git checkout -b add-python-reviewer
```

### 3. 添加你的贡献

将文件放置在适当的目录中：
- `agents/` 用于新智能体
- `skills/` 用于技能（可以是单个 .md 文件或目录）
- `commands/` 用于斜杠指令
- `rules/` 用于规则文件
- `hooks/` 用于钩子配置
- `mcp-configs/` 用于 MCP 服务器配置

### 4. 遵循格式

**智能体 (Agents)** 应包含 frontmatter：

```markdown
---
name: agent-name
description: What it does
tools: Read, Grep, Glob, Bash
model: sonnet
---

Instructions here...
```

**技能 (Skills)** 应清晰且可操作：

```markdown
# Skill Name

## When to Use

...

## How It Works

...

## Examples

...
```

**指令 (Commands)** 应解释其作用：

```markdown
---
description: Brief description of command
---

# Command Name

Detailed instructions...
```

**钩子 (Hooks)** 应包含描述：

```json
{
  "matcher": "...",
  "hooks": [...],
  "description": "What this hook does"
}
```

### 5. 测试你的贡献

在提交之前，确保你的配置能在 Claude Code 中正常工作。

### 6. 提交 PR

```bash
git add .
git commit -m "Add Python code reviewer agent"
git push origin add-python-reviewer
```

然后开启一个 PR，包含：
- 你添加了什么
- 为什么它有用
- 你是如何测试它的

---

## 准则

### 要做 (Do)

- 保持配置专注和模块化
- 包含清晰的描述
- 提交前进行测试
- 遵循现有模式
- 记录任何依赖项

### 不要 (Don't)

- 包含敏感数据（API 密钥、令牌、路径）
- 添加过于复杂或小众的配置
- 提交未经测试的配置
- 创建重复的功能
- 添加需要特定付费服务且无替代方案的配置

---

## 文件命名

- 使用小写字母和连字符：`python-reviewer.md`
- 描述性强：用 `tdd-workflow.md` 而不是 `workflow.md`
- 保持智能体/技能名称与文件名一致

---

## 有疑问？

开启 Issue 或在 X 上联系：[@affaanmustafa](https://x.com/affaanmustafa)

---

感谢你的贡献。让我们一起构建优秀的资源。
