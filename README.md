# Claude Code 中文开发套件

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Language: 中文](https://img.shields.io/badge/Language-%E4%B8%AD%E6%96%87-red.svg)](README.md)
[![Version](https://img.shields.io/github/v/release/cfrs2005/claude-init)](https://github.com/cfrs2005/claude-init/releases/latest)
[![Downloads](https://img.shields.io/github/downloads/cfrs2005/claude-init/total)](https://github.com/cfrs2005/claude-init/releases)
[![Stars](https://img.shields.io/github/stars/cfrs2005/claude-init)](https://github.com/cfrs2005/claude-init/stargazers)
[![Forks](https://img.shields.io/github/forks/cfrs2005/claude-init)](https://github.com/cfrs2005/claude-init/network/members)
[![Issues](https://img.shields.io/github/issues/cfrs2005/claude-init)](https://github.com/cfrs2005/claude-init/issues)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)
[![Platform](https://img.shields.io/badge/Platform-macOS%20%7C%20Linux%20%7C%20Windows-lightgrey)](README.md)
[![Claude Code](https://img.shields.io/badge/Compatible-Claude%20Code-blue)](https://github.com/anthropics/claude-code)
[![MCP](https://img.shields.io/badge/Support-MCP%20Servers-green)](README.md#mcp-服务器支持)

<div align="center">

🚀 **为中国开发者定制的 Claude Code 智能开发环境**

[快速开始](#-快速开始) • [功能特性](#-特性) • [使用指南](#-使用指南) • [使用反馈](#-使用反馈) • [更新日志](CHANGELOG.md)

---


🚀 **新增智谱AI引擎**: 最新集成了 **[智谱大模型 (BigModel.cn)](https://www.bigmodel.cn/claude-code?ic=H0RNPV3LNZ)**。其旗舰 **GLM-4.5** 模型拥有媲美 Claude 的代码能力，并提供极具吸引力的包月服务，是入门和高频使用的绝佳选择。 **[点此注册即领2000万免费Tokens →](https://www.bigmodel.cn/claude-code?ic=H0RNPV3LNZ)**

</div>

基于 [Claude Code Development Kit](https://github.com/peterkrueck/Claude-Code-Development-Kit) 的完整中文本地化版本，提供零门槛的中文 AI 编程体验。

## ✨ 特性

### 🎯 完全中文化
- **中文 AI 指令** - 所有 AI 上下文和提示完全中文化
- **中文文档系统** - 三层文档架构的中文版本
- **中文错误信息** - 友好的中文错误提示和帮助
- **中文安装体验** - 从安装到配置全程中文

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

## 🚀 快速开始

### 📋 系统要求

**在开始之前，请确保已安装：**

1. **Git** - [下载地址](https://git-scm.com/downloads)
   - Windows 用户需要先安装 Git 才能使用 Git Bash
   - 安装时选择 "Use Git and optional Unix tools from the Command Prompt"

2. **Claude Code** - [官方安装指南](https://github.com/anthropics/claude-code)
   - 确保可以在命令行中运行 `claude` 命令

### 💻 Windows 用户安装指南

#### 方法一：一键安装（推荐）

1. **打开 Git Bash** （不是CMD或PowerShell）
   - 在桌面右键 → Git Bash Here
   - 或从开始菜单打开 Git Bash

2. **运行安装命令：**
   ```bash
   curl -fsSL https://raw.githubusercontent.com/cfrs2005/claude-init/main/install.sh | bash
   ```

#### 方法二：手动安装

1. **打开 Git Bash**

2. **克隆仓库：**
   ```bash
   git clone https://github.com/cfrs2005/claude-init.git
   cd claude-init
   ```

3. **运行安装脚本：**
   ```bash
   ./setup.sh
   ```

### 🍎 macOS / 🐧 Linux 用户安装

#### 一键安装
```bash
curl -fsSL https://raw.githubusercontent.com/cfrs2005/claude-init/main/install.sh | bash
```

#### 手动安装
```bash
# 克隆仓库
git clone https://github.com/cfrs2005/claude-init.git
cd claude-init

# 运行安装脚本
chmod +x setup.sh
./setup.sh
```

## 📖 使用指南

### 🎯 这个项目是做什么的？

Claude Code 中文开发套件是一个**增强工具包**，它：

- **不是 Claude Code 的替代品** - 而是让 Claude Code 变得更强大
- **提供中文化界面** - 让你可以用中文和 AI 对话
- **添加智能功能** - 如自动文档管理、代码审查助手等
- **集成外部服务** - 连接 Gemini AI、Context7 文档库等

### 🚀 如何开始使用

#### 第一步：安装完成后的检查

安装完成后，你会看到这些新增文件：
- `CLAUDE.md` - AI 上下文配置文件
- `docs/` - 中文文档系统
- `.claude/` - 增强功能和配置
- `examples/` - 使用示例

#### 第二步：启动 Claude Code

在**任意项目目录**中打开终端（Windows 用户使用 Git Bash），然后运行：

```bash
claude
```

#### 第三步：开始中文对话

现在你可以：
- 用中文向 AI 描述需求
- AI 会理解中文并回复中文
- 所有技术术语都会保持准确

#### 第四步：使用增强功能

安装后可使用的特殊命令：

```bash
# 在 Claude Code 中输入这些斜杠命令：
/full-context          # 全面分析项目上下文
/code-review           # 多角度代码审查
/gemini-consult        # 咨询 Gemini AI 获取建议
/create-docs           # 创建项目文档
/update-docs           # 更新现有文档
/refactor              # 智能重构代码
/mcp-status            # 检查扩展服务状态
```

### 💡 实际使用示例

#### 示例1：创建新项目
```bash
# 1. 创建项目文件夹
mkdir my-python-project
cd my-python-project

# 2. 启动 Claude Code
claude

# 3. 用中文对话：
# "请帮我创建一个 Python 项目，包含用户认证功能和数据库操作"
```

#### 示例2：代码审查
```bash
# 在项目中启动 Claude Code
claude

# 输入命令：
/code-review

# AI 会自动分析所有代码并提供改进建议
```

#### 示例3：获取技术咨询
```bash
# 在 Claude Code 中：
/gemini-consult

# 然后描述你的问题：
# "我正在设计一个电商系统，请帮我分析架构设计"
```

### 2. 🎯 MCP 服务器功能

#### 🧠 Gemini 深度咨询
**触发方式：** 对 Claude 说"咨询 Gemini" 或 "请 Gemini 分析"
**适用场景：**
- 复杂架构设计问题
- 代码性能优化建议  
- 多文件代码重构方案
- 深度技术问题分析

**发送内容：**
- 描述你的具体问题
- 附上相关代码文件
- 说明你想要什么类型的建议

**Gemini 能做什么：**
- 提供多种解决方案对比
- 深度代码审查和优化建议
- 架构设计最佳实践
- 跨技术栈的经验分享

#### 📚 Context7 文档查询  
**触发方式：** 询问任何开源库的最新用法
**适用场景：**
- 学习新框架或库
- 查找最新 API 文档
- 解决版本兼容问题

**发送内容：**
- 说出库名称（如 "React 的最新 hooks 用法"）
- 描述你想解决的具体问题

**Context7 能做什么：**
- 获取最新官方文档
- 提供实用代码示例
- 解释最新特性和变化

### 3. 💡 增强功能

#### 🎵 自定义通知音效
**默认路径：** `.claude/hooks/sounds/`
**支持格式：** `.mp3`, `.wav`, `.aiff`

**替换方式：**
```bash
# 替换任务完成音效
cp your-sound.mp3 .claude/hooks/sounds/complete.mp3

# 替换输入提示音效  
cp your-sound.mp3 .claude/hooks/sounds/input.mp3
```

#### 🔒 安全扫描
**自动功能：** 所有 MCP 调用前自动检查敏感信息
**检查内容：**
- API 密钥和令牌
- 密码和敏感配置
- 个人身份信息
- 私有代码片段

#### 🤖 智能上下文管理
**自动功能：** 子任务自动获取项目上下文
**工作方式：**
- 每个新任务自动加载项目文档
- 智能选择相关上下文信息
- 保持会话间状态一致性

### 4. 🎯 Claude Code 斜杠命令

安装后可使用的内置 Claude Code 命令：

```bash
# 📊 上下文分析
/full-context               # 全面上下文收集和分析

# 🔍 代码质量
/code-review               # 多专家角度代码审查  

# 🧠 AI 咨询 
/gemini-consult            # 与 Gemini 深入对话咨询

# 📝 文档管理
/create-docs               # 创建 AI 优化文档结构
/update-docs               # 保持文档与代码同步

# ♻️ 代码维护
/refactor                  # 智能重构代码

# 🤝 会话管理  
/handoff                   # 保留上下文和任务状态

# 📡 MCP 工具
/mcp-status                # 检查 MCP 服务器状态
```

**使用方式：** 直接在 Claude Code 中输入斜杠命令  
**自动功能：** 所有命令自动获得项目上下文注入

## ❓ 常见问题解答

### 🔧 Windows 用户常见问题

#### Q: 为什么必须使用 Git Bash？
**A:** Windows 的 CMD 和 PowerShell 不支持 Unix 风格的脚本。Git Bash 提供了完整的 Linux 兼容环境，可以正常运行安装脚本。

#### Q: 安装成功后，为什么运行 `claude` 命令提示找不到？
**A:** 这说明 Claude Code 没有正确安装或没有添加到系统 PATH。
1. 重新安装 [Claude Code](https://github.com/anthropics/claude-code)
2. 确保安装时选择了 "Add to PATH" 选项
3. 重启终端后再试

#### Q: 安装脚本运行时出现权限错误？
**A:** 在 Git Bash 中运行：
```bash
chmod +x setup.sh
./setup.sh
```

#### Q: 如何验证安装是否成功？
**A:** 检查项目目录中是否出现这些文件：
- `CLAUDE.md` 
- `docs/` 文件夹
- `.claude/` 文件夹
- `examples/` 文件夹

#### Q: 安装后没有看到中文化效果？
**A:** 确保在安装了套件的项目目录中运行 `claude`，而不是在其他目录。

### 💻 其他平台问题

#### Q: macOS/Linux 出现 "command not found: curl"？
**A:** 安装 curl：
```bash
# macOS
brew install curl

# Ubuntu/Debian  
sudo apt-get install curl

# CentOS/RHEL
sudo yum install curl
```

#### Q: MCP 服务器无法连接？
**A:** 检查网络连接和 API 密钥配置，运行 `/mcp-status` 查看状态。

## 💬 使用反馈

### 🐛 问题反馈
**遇到问题？** [提交 Issue](https://github.com/cfrs2005/claude-init/issues)

**反馈时请包含：**
- 操作系统版本
- 错误信息截图
- 安装方式（一键/手动）
- 具体的操作步骤

### 💡 功能建议
**想要新功能？** [发起讨论](https://github.com/cfrs2005/claude-init/discussions)

**建议包含：**
- 功能描述和使用场景
- 期望的工作方式
- 类似工具的参考

### 🤝 参与贡献
欢迎提交代码、文档改进和翻译优化！

## 📄 开源协议

本项目基于 [MIT License](LICENSE) 开源。

## 🙏 致谢

- [Claude Code Development Kit](https://github.com/peterkrueck/Claude-Code-Development-Kit) - 原始项目
- [Anthropic](https://www.anthropic.com/) - Claude Code 平台
- 所有贡献者和中文开发社区

---

🎉 **开始你的中文 AI 编程之旅吧！**

```bash
curl -fsSL https://raw.githubusercontent.com/cfrs2005/claude-init/main/install.sh | bash
```