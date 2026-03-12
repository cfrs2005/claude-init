# Claude Code 项目初始化模板

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Language: 中文](https://img.shields.io/badge/Language-%E4%B8%AD%E6%96%87-red.svg)](README.md)
[![Version](https://img.shields.io/github/v/release/cfrs2005/claude-init)](https://github.com/cfrs2005/claude-init/releases/latest)
[![Downloads](https://img.shields.io/github/downloads/cfrs2005/claude-init/total)](https://github.com/cfrs2005/claude-init/releases)
[![Stars](https://img.shields.io/github/stars/cfrs2005/claude-init)](https://github.com/cfrs2005/claude-init/stargazers)
[![Forks](https://img.shields.io/github/forks/cfrs2005/claude-init)](https://github.com/cfrs2005/claude-init/network/members)
[![Issues](https://img.shields.io/github/issues/cfrs2005/claude-init)](https://github.com/cfrs2005/claude-init/issues)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)
[![Platform](https://img.shields.io/badge/Platform-macOS%20%7C%20Linux-lightgrey)](README.md)
[![Claude Code](https://img.shields.io/badge/Reference-Claude%20Code-blue)](https://github.com/anthropics/claude-code)

<div align="center">

⚠️ **项目归档说明：仅供学习参考**

[项目背景](#-项目背景) • [功能特性](#-特性) • [使用指南](#-使用指南) • [注意事项](#-important-注意事项) • [更新日志](CHANGELOG.md)

---

</div>

> **📅 项目时间：** 2025年07月  
> **🎯 项目定位：** Claude Code 项目初始化工具（**非 Claude 汉化项目**）  
> **⚠️ 当前状态：** Claude Code 版本快速迭代，本项目仅作为学习参考

## 📋 项目背景

本项目创建于 2025年07月，当时 Claude Code 在国内开发社区刚刚兴起。作为一个项目初始化工具，旨在帮助开发者快速搭建基于 Claude Code 的开发环境。

**⚠️ 重要说明：**
- 本项目 **不是** Claude Code 的汉化版本
- 本项目 **不是** Claude Code 的官方替代品
- Claude Code 官方版本更新频繁，本项目配置可能已过时
- 建议直接使用 [Claude Code 官方版本](https://github.com/anthropics/claude-code) 并参考[官方中文文档](https://docs.anthropic.com/zh-CN/docs/claude-code)

### 支持平台

- ✅ **macOS** - 完全支持
- ✅ **Linux** - 完全支持  
- ❌ **Windows** - **不支持**（作者无 Windows 环境，无法测试和维护）

---

## 🏆 v1.3.0 版本：集成 Anthropic 黑客松冠军配置

<div align="center">

**🥇 融合 Anthropic x Forum Ventures 黑客松冠军 [@affaanmustafa](https://x.com/affaanmustafa) 的完整生产级配置 🥇**

[Everything Claude Code](https://github.com/affaan-m/everything-claude-code) | [完整指南](https://x.com/affaanmustafa/status/2012378465664745795)

</div>

本版本集成了 **Everything Claude Code** 的完整汉化配置——这是 **Anthropic 官方 x Forum Ventures 黑客松冠军团队**在构建 [zenith.chat](https://zenith.chat) 等真实产品过程中，历经 **10 个月高强度开发** 迭代出的生产级配置合集。原作者 [@affaanmustafa](https://x.com/affaanmustafa) 与 [@DRodriguezFX](https://x.com/DRodriguezFX) 凭借这套配置赢得了 Anthropic 官方举办的黑客马拉松冠军。所有配置文件均已完成中文本地化，开箱即用。

### 📦 新增核心组件

| 组件 | 数量 | 用途 |
|------|------|------|
| **智能体 (Agents)** | 9 个 | 专用子智能体，处理范围受限的委派任务 |
| **技能 (Skills)** | 7+ | 工作流定义与领域知识，由指令或智能体调用 |
| **指令 (Commands)** | 10 个 | 快捷斜杠指令，一键执行复杂工作流 |
| **规则 (Rules)** | 8 个 | 必须遵循的强制性准则 |
| **钩子 (Hooks)** | 多个 | 基于触发器的自动化脚本 |
| **上下文 (Contexts)** | 3 个 | 开发/研究/审查三种工作模式 |

### 🤖 智能体 (Agents) 详解

智能体是处理特定任务的专用子流程，每个智能体都有明确的职责边界：

- **`planner.md`** - 功能实现规划，分解复杂需求为可执行步骤
- **`architect.md`** - 系统设计决策，架构方案评估与选型
- **`tdd-guide.md`** - 测试驱动开发导师，指导 RED-GREEN-REFACTOR 循环
- **`code-reviewer.md`** - 代码质量与安全审查，多维度评估代码
- **`security-reviewer.md`** - 专业漏洞分析，安全威胁识别
- **`build-error-resolver.md`** - 构建错误快速诊断与修复
- **`e2e-runner.md`** - Playwright 端到端测试执行
- **`refactor-cleaner.md`** - 死代码清理，技术债务消除
- **`doc-updater.md`** - 文档与代码同步维护

### ⚡ 快捷指令 (Commands)

在 Claude Code 中直接输入斜杠指令，一键触发复杂工作流：

```bash
/tdd              # 测试驱动开发流程
/plan             # 功能实现规划
/e2e              # 生成端到端测试
/code-review      # 代码质量审查
/build-fix        # 修复构建错误
/refactor-clean   # 移除死代码
/test-coverage    # 测试覆盖率分析
/update-codemaps  # 刷新代码地图
/update-docs      # 同步文档
/learn            # 学习新技术
```

### 📐 规则 (Rules) 体系

规则是必须始终遵循的准则，确保代码质量和团队协作：

- **`security.md`** - 禁止硬编码密钥，强制安全检查
- **`coding-style.md`** - 不可变性设计，文件组织规范
- **`testing.md`** - TDD 原则，80% 覆盖率要求
- **`git-workflow.md`** - 提交格式规范，PR 流程标准
- **`agents.md`** - 何时委派给子智能体的决策准则
- **`performance.md`** - 模型选择策略，上下文管理最佳实践
- **`patterns.md`** - API 响应格式，设计模式规范
- **`hooks.md`** - 钩子系统使用文档

### 🎯 上下文窗口管理（关键）

> ⚠️ **重要提示**：不要一次性启用所有 MCP。如果启用太多工具，你的 200k 上下文窗口可能缩减到 70k。

**经验法则：**
- 配置 20-30 个 MCP 服务器
- 每个项目保持启用少于 10 个
- 活跃工具数量控制在 80 个以内
- 使用 `disabledMcpServers` 禁用未使用的服务

### 📂 目录结构

所有新增配置位于 `templates/.claude/` 目录：

```
templates/.claude/
├── agents/           # 9 个专用子智能体
├── skills/           # 工作流定义与领域知识  
├── commands/         # 10 个快捷斜杠指令
├── rules/            # 8 个强制性规则
├── hooks/            # 自动化钩子脚本
├── contexts/         # 3 种工作上下文模式
├── mcp-configs/      # MCP 服务器配置示例
├── plugins/          # 插件生态系统文档
└── examples/         # 配置示例和会话记录
```

**使用方式**：根据需要将配置复制到 `~/.claude/` 目录，针对你的技术栈进行定制。

---

## ✨ 特性

### 🎯 项目初始化模板
- **快速启动** - 预配置的项目结构和开发环境
- **中文文档** - 项目初始化相关的中文说明文档
- **配置示例** - 常用开发场景的配置文件模板
- **学习参考** - Claude Code 配置和最佳实践的学习案例

### 🧠 智能上下文管理
- **三层文档架构** - 基础层/组件层/功能层分级管理
- **自动上下文注入** - 子智能体自动获取项目上下文
- **智能文档路由** - 根据任务复杂度加载适当文档
- **跨会话状态管理** - 智能任务交接和状态保持

### 🔧 开发工具集成
- **Hook 系统** - 中文化的自动化 Hook 脚本
- **MCP 服务器支持** - Gemini 咨询、Context7 文档等
- **安全扫描** - 自动 MCP 调用安全检查
- **通知系统** - 重要事件的系统通知

### 📚 完整模板库
- **项目模板** - 多种编程语言的项目结构模板
- **文档模板** - 标准化的中文文档模板
- **配置示例** - 开箱即用的配置文件
- **Skills 扩展** - 模块化的能力扩展系统
- **示例项目** - Python、Node.js、Web 应用完整示例

## 🚀 快速开始

### 推荐方式：使用官方 Claude Code

**强烈建议**直接使用官方最新版本：

1. **安装 Claude Code**
   ```bash
   # 访问官方文档获取最新安装方法
   https://docs.anthropic.com/zh-CN/docs/claude-code
   ```

2. **参考本项目配置**
   ```bash
   # 克隆本仓库作为参考
   git clone https://github.com/cfrs2005/claude-init.git
   cd claude-init
   
   # 查看配置文件，根据需要调整你的 Claude Code 设置
   ls templates/.claude/
   ```

### 使用本项目的配置模板

如果你想参考本项目的配置：

### 1. 配置文件说明

本项目的配置文件位于 `templates/.claude/` 目录：

```
templates/.claude/
├── agents/           # 智能体配置示例
├── skills/           # 技能配置示例  
├── commands/         # 命令配置示例
├── rules/            # 规则配置示例
├── hooks/            # 钩子脚本示例
├── contexts/         # 上下文配置示例
└── mcp-configs/      # MCP 服务器配置示例
```

### 2. 参考使用

```bash
# 查看感兴趣的配置文件
cat templates/.claude/agents/planner.md

# 复制有用的配置到你的 Claude Code 目录
cp templates/.claude/agents/planner.md ~/.claude/agents/
```

## 📖 学习参考

### 1. 🎯 MCP 服务器功能

#### 🧠 Gemini 深度咨询
> **注意：** 以下功能配置仅供参考，可能需要根据最新 Claude Code 版本调整

**触发方式：** 对 Claude 说"咨询 Gemini" 或 "请 Gemini 分析"
**适用场景：**
- 复杂架构设计问题
- 代码性能优化建议  
- 多文件代码重构方案
- 深度技术问题分析

#### 📚 Context7 文档查询  
> **注意：** 以下功能配置仅供参考，可能需要根据最新 Claude Code 版本调整

**触发方式：** 询问任何开源库的最新用法
**适用场景：**
- 学习新框架或库
- 查找最新 API 文档
- 解决版本兼容问题

### 2. 💡 增强功能

#### 🎵 自定义通知音效
> **配置参考：** 钩子脚本配置示例

**默认路径：** `.claude/hooks/sounds/`
**支持格式：** `.mp3`, `.wav`, `.aiff`

#### 🔒 安全扫描
> **配置参考：** 安全检查钩子示例

**功能：** MCP 调用前自动检查敏感信息

#### 🤖 智能上下文管理
> **配置参考：** 上下文管理配置示例

**功能：** 子任务自动获取项目上下文

### 3. 🎯 Claude Code 斜杠命令

> **配置参考：** 命令配置文件示例

以下为本项目包含的命令配置示例：

```bash
# 📊 上下文分析
/full-context               # 全面上下文收集和分析

# 🔍 代码质量
/code-review               # 多专家角度代码审查

# 📝 文档管理
/create-docs               # 创建 AI 优化文档结构
/update-docs               # 保持文档与代码同步

# ♻️ 代码维护
/refactor                  # 智能重构代码

# 🤝 会话管理
/handoff                   # 保留上下文和任务状态
```

**注意：** 具体可用命令请参考官方最新文档

### 4. 🎯 Skills 模块化能力扩展

> **配置参考：** Skills 配置文件示例

**什么是 Skills？** Skills 是 [Claude Code 云服务](https://www.anthropic.com/news/claude-code-on-the-web)的强大功能，让你创建可复用的能力模块。

**本项目包含的 Skills 示例：**
- 📰 **News Skill** - 新闻追踪和深度分析示例

**详细文档：** 查看 `templates/.claude/skills/README.md`
**了解更多：** [Claude Code 云服务介绍](https://www.anthropic.com/news/claude-code-on-the-web)

### 5. 📦 项目示例库

> **学习参考：** 项目结构配置示例

本项目包含以下项目模板示例：

#### 🐍 Python 项目
- FastAPI Web 应用结构
- 数据科学项目配置
- 机器学习工作流

#### 🟢 Node.js 项目
- Express.js API 服务
- React 全栈应用
- 微服务架构

#### 🌐 Web 应用
- 前后端分离架构
- 移动端适配
- 部署和运维配置

**参考方式：**
```bash
# 查看示例项目
ls examples/

# 参考项目结构和配置
cat examples/python-project/README.md
```

**详细文档：** 查看 `examples/README.md`

## ⚠️ Important 注意事项

### 版本兼容性
- Claude Code 官方版本更新频繁，API 和配置可能发生变化
- 本项目的配置文件可能需要根据最新版本进行调整
- 建议始终参考 [官方文档](https://docs.anthropic.com/zh-CN/docs/claude-code) 获取最新信息

### 平台支持
- ✅ **macOS** - 完全支持
- ✅ **Linux** - 完全支持  
- ❌ **Windows** - **不支持**（作者无 Windows 环境，无法提供支持）

### 项目定位
- 本项目是 **学习参考** 项目，不是官方产品
- 本项目 **不是** Claude Code 的汉化版本
- 本项目提供配置文件示例和最佳实践参考
- 遇到问题请首先查阅 [官方文档](https://docs.anthropic.com/zh-CN/docs/claude-code)

### 学习资源
**官方推荐学习路径：**
1. 📖 [Claude Code 官方文档](https://docs.anthropic.com/zh-CN/docs/claude-code) - 完整的中文使用指南
2. 🚀 [Claude Code GitHub 仓库](https://github.com/anthropics/claude-code) - 最新版本和更新
3. 💡 [官方示例和最佳实践](https://docs.anthropic.com/zh-CN/docs/claude-code/examples) - 官方推荐用法

## 💬 使用反馈

### 🐛 问题反馈
**遇到问题？** 

1. **首先查阅官方文档** - 大部分问题都能在官方文档中找到解决方案
2. **检查版本兼容性** - 确认你使用的 Claude Code 版本与配置文件匹配
3. **搜索已有 Issues** - 查看是否有类似问题已经被讨论
4. **提交新 Issue** - 如果以上都没有解决，可以 [提交 Issue](https://github.com/cfrs2005/claude-init/issues)

**Issue 提示：**
- 详细描述问题和复现步骤
- 说明你的操作系统和 Claude Code 版本
- 提供相关的错误信息和配置文件

### 💡 功能建议
**想要新功能？** 

1. **先确认是否为官方功能** - 查看官方文档确认是否已是内置功能
2. **发起讨论** - 在 [Discussions](https://github.com/cfrs2005/claude-init/discussions) 中讨论想法
3. **提交 PR** - 如果你是配置改进，欢迎提交 Pull Request

### 🤝 参与贡献
欢迎提交配置改进、文档修正和示例优化！

## 📄 开源协议

本项目基于 [MIT License](LICENSE) 开源。

## 🙏 致谢

- [Claude Code Development Kit](https://github.com/peterkrueck/Claude-Code-Development-Kit) - 原始项目灵感来源
- [Everything Claude Code](https://github.com/affaan-m/everything-claude-code) - Anthropic 黑客松优胜者配置参考
- [Anthropic](https://www.anthropic.com/) - Claude Code 官方平台
- 所有贡献者和开发社区

> 💡 **推荐学习资源**：
> - 📖 [Claude Code 官方中文文档](https://docs.anthropic.com/zh-CN/docs/claude-code)
> - 🚀 [Claude Code 官方 GitHub](https://github.com/anthropics/claude-code)
> - 💡 [官方示例和最佳实践](https://docs.anthropic.com/zh-CN/docs/claude-code/examples)

---

🎓 **本项目仅供学习参考，建议使用官方最新版本！**

```bash
# 访问官方文档开始使用
https://docs.anthropic.com/zh-CN/docs/claude-code
```