# 代码审查 (Code Review)

对未提交的更改进行全面的安全和质量审查：

1. 获取更改的文件：`git diff --name-only HEAD`

2. 对每个更改的文件，检查：

**安全问题 (CRITICAL - 严重):**
- 硬编码的凭证、API 密钥、令牌
- SQL 注入漏洞
- XSS 漏洞
- 缺少输入验证
- 不安全的依赖
- 路径遍历风险

**代码质量 (HIGH - 高):**
- 函数 > 50 行
- 文件 > 800 行
- 嵌套深度 > 4 层
- 缺少错误处理
- console.log 语句
- TODO/FIXME 注释
- 公共 API 缺少 JSDoc

**最佳实践 (MEDIUM - 中):**
- 变异模式 (Mutation patterns) (建议使用不可变模式)
- 代码/注释中的 Emoji 使用
- 新代码缺少测试
- 无障碍问题 (a11y)

3. 生成报告包含：
   - 严重程度: CRITICAL (严重), HIGH (高), MEDIUM (中), LOW (低)
   - 文件位置和行号
   - 问题描述
   - 建议的修复

4. 如果发现 CRITICAL 或 HIGH 问题，阻止提交

绝不批准带有安全漏洞的代码！
