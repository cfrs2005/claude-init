# Git 工作流

## 提交信息格式

```
<类型>: <描述>

<可选正文>
```

类型：feat (特性), fix (修复), refactor (重构), docs (文档), test (测试), chore (杂项), perf (性能), ci (集成)

注意：已通过 `~/.claude/settings.json` 全局禁用作者归属 (Attribution)。

## Pull Request 工作流

创建 PR 时：
1. 分析完整提交历史 (不仅是最后一次提交)
2. 使用 `git diff [base-branch]...HEAD` 查看所有变更
3. 起草全面的 PR 摘要
4. 包含带有 TODO 的测试计划
5. 如果是新分支，推送时带上 `-u` 参数

## 特性实现工作流

1. **规划先行**
   - 使用 **planner** (规划师) 智能体制定实现计划
   - 识别依赖和风险
   - 拆解为多个阶段

2. **TDD (测试驱动开发) 方法**
   - 使用 **tdd-guide** (TDD向导) 智能体
   - 先写测试 (红 - RED)
   - 实现代码以通过测试 (绿 - GREEN)
   - 重构 (改进 - IMPROVE)
   - 验证覆盖率达到 80%+

3. **代码审查**
   - 代码编写完成后立即使用 **code-reviewer** (代码审查者) 智能体
   - 解决 CRITICAL (严重) 和 HIGH (高) 优先级问题
   - 尽可能解决 MEDIUM (中) 优先级问题

4. **提交与推送**
   - 详细的提交信息
   - 遵循约定式提交 (Conventional Commits) 格式
