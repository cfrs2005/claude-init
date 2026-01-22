# 插件与市场

插件能为 Claude Code 扩展新的工具与能力。本文档仅涵盖安装指南——关于何时以及为何使用插件，请参阅[完整文章](https://x.com/affaanmustafa/status/2012378465664745795)。

---

## 市场 (Marketplaces)

市场是可安装插件的仓库。

### 添加市场

```bash
# 添加官方 Anthropic 市场
claude plugin marketplace add https://github.com/anthropics/claude-plugins-official

# 添加社区市场
claude plugin marketplace add https://github.com/mixedbread-ai/mgrep
```

### 推荐市场

| 市场名称 | 来源 |
|-------------|--------|
| claude-plugins-official | `anthropics/claude-plugins-official` |
| claude-code-plugins | `anthropics/claude-code` |
| Mixedbread-Grep | `mixedbread-ai/mgrep` |

---

## 安装插件

```bash
# 打开插件浏览器
/plugins

# 或者直接安装
claude plugin install typescript-lsp@claude-plugins-official
```

### 推荐插件

**开发类：**
- `typescript-lsp` - TypeScript 智能提示
- `pyright-lsp` - Python 类型检查
- `hookify` - 对话式创建 Hook
- `code-simplifier` - 代码重构

**代码质量类：**
- `code-review` - 代码评审
- `pr-review-toolkit` - PR 自动化
- `security-guidance` - 安全检查

**搜索类：**
- `mgrep` - 增强搜索 (优于 ripgrep)
- `context7` - 实时文档查找

**工作流类：**
- `commit-commands` - Git 工作流
- `frontend-design` - UI 模式
- `feature-dev` - 特性开发

---

## 快速配置

```bash
# 添加市场
claude plugin marketplace add https://github.com/anthropics/claude-plugins-official
claude plugin marketplace add https://github.com/mixedbread-ai/mgrep

# 打开 /plugins 并按需安装
```

---

## 插件文件路径

```
~/.claude/plugins/
|-- cache/                    # 已下载的插件
|-- installed_plugins.json    # 已安装列表
|-- known_marketplaces.json   # 已添加市场
|-- marketplaces/             # 市场数据
```
