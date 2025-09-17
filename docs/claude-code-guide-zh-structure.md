# Claude Code 指南中文翻译项目 - 目录结构

## 项目根目录
```
/home/runner/work/claude-init/claude-init/docs/claude-code-guide-zh/
```

## 目录结构说明

### 主要目录
- **01-introduction/** - 第一部分：基础入门
- **02-core-features/** - 第二部分：核心功能  
- **03-advanced-features/** - 第三部分：高级功能
- **04-best-practices/** - 第四部分：最佳实践
- **05-practical-examples/** - 第五部分：实战案例
- **06-reference/** - 第六部分：参考和资源

### 预期的文件结构

```
claude-code-guide-zh/
├── README.md                           # 项目总览
├── terminology.md                      # 术语表
├── translation-guide.md               # 翻译指南
├── 01-introduction/                    # 基础入门
│   ├── chapter-01-overview.md         # 概述和介绍
│   ├── chapter-02-installation.md     # 安装和配置
│   ├── chapter-03-quick-start.md      # 快速开始
│   └── section-environment-setup.md   # 环境设置
├── 02-core-features/                   # 核心功能
│   ├── chapter-04-basic-usage.md      # 基本使用
│   ├── chapter-05-command-line.md     # 命令行工具
│   ├── chapter-06-configuration.md    # 配置管理
│   └── section-file-operations.md     # 文件操作
├── 03-advanced-features/               # 高级功能
│   ├── chapter-07-workflow.md         # 工作流程
│   ├── chapter-08-automation.md       # 自动化功能
│   ├── chapter-09-integration.md      # 集成功能
│   └── section-advanced-patterns.md   # 高级模式
├── 04-best-practices/                  # 最佳实践
│   ├── chapter-10-project-structure.md # 项目结构
│   ├── chapter-11-teamwork.md         # 团队协作
│   ├── chapter-12-performance.md      # 性能优化
│   └── section-security.md            # 安全实践
├── 05-practical-examples/              # 实战案例
│   ├── chapter-13-common-scenarios.md # 常见场景
│   ├── chapter-14-troubleshooting.md  # 问题排查
│   ├── chapter-15-advanced-tips.md    # 高级技巧
│   └── section-real-world-cases.md    # 真实案例
└── 06-reference/                       # 参考资源
    ├── chapter-16-api-reference.md    # API参考
    ├── chapter-17-appendix.md         # 附录
    ├── chapter-18-community.md        # 社区资源
    └── section-cheatsheet.md           # 速查表
```

## 文件命名规范

### 章节文件命名
- **chapter-XX-*.md** - 主要章节文件
- **section-*.md** - 小节文件
- **subsection-*.md** - 子小节文件

### 文件名格式
- 使用小写字母
- 单词间用连字符连接
- 包含章节编号以便排序
- 使用有意义的名称

### 示例
- `chapter-01-overview.md` ✓
- `section-installation-guide.md` ✓
- `subsection-advanced-config.md` ✓

## 内容组织原则

### 1. 层次结构
- 层级1：主要部分（01-06）
- 层级2：章节（chapter-XX）
- 层级3：小节（section）
- 层级4：子小节（subsection）

### 2. 内容分配
- **基础知识** → 01-introduction
- **核心功能** → 02-core-features  
- **高级特性** → 03-advanced-features
- **最佳实践** → 04-best-practices
- **实际应用** → 05-practical-examples
- **参考资料** → 06-reference

### 3. 导航设计
- 每个目录包含独立的 README.md
- 章节间建立明确的引用关系
- 提供完整的目录索引

## 翻译质量标准

### 1. 技术准确性
- 保持技术概念准确
- 代码示例保持原样
- 命令行参数不翻译

### 2. 语言质量
- 使用地道中文表达
- 避免生硬直译
- 保持术语一致性

### 3. 格式规范
- Markdown格式标准
- 代码块格式统一
- 链接引用正确

## 版本控制

### 分支策略
- `main` - 主分支（稳定版本）
- `develop` - 开发分支
- `feature/*` - 功能分支
- `translation/*` - 翻译分支

### 提交规范
- `feat: 添加新章节翻译`
- `fix: 修正翻译错误`
- `docs: 更新文档结构`
- `style: 格式调整`
- `refactor: 重构内容`

## 贡献指南

### 1. Fork 项目
- 从主仓库创建分支
- 在本地进行翻译工作
- 提交 Pull Request

### 2. 翻译流程
- 选择要翻译的章节
- 遵循翻译规范
- 进行质量检查
- 提交更改

### 3. 质量保证
- 技术准确性检查
- 语言表达优化
- 格式一致性验证

## 工具和资源

### 翻译工具
- 专业翻译软件
- 术语管理工具
- 版本控制系统

### 质量检查
- 拼写语法检查
- 链接有效性验证
- 格式一致性检查

---

*此目录结构为预设模板，实际结构将根据原始文档内容进行调整。*