# 安全指南

## 强制性安全检查

在**任何**提交之前：
- [ ] 无硬编码密钥 (API Key, 密码, Token)
- [ ] 所有用户输入均已验证
- [ ] 防止 SQL 注入 (参数化查询)
- [ ] 防止 XSS (HTML 净化)
- [ ] 启用 CSRF 保护
- [ ] 验证认证/授权
- [ ] 所有端点启用速率限制
- [ ] 错误信息不泄露敏感数据

## 密钥管理

```typescript
// 绝不：硬编码密钥
const apiKey = "sk-proj-xxxxx"

// 务必：环境变量
const apiKey = process.env.OPENAI_API_KEY

if (!apiKey) {
  throw new Error('OPENAI_API_KEY 未配置')
}
```

## 安全响应协议

若发现安全问题：
1. 立即停止
2. 使用 **security-reviewer** (安全审查者) 智能体
3. 在继续前修复 CRITICAL (严重) 问题
4. 轮换任何泄露的密钥
5. 审查整个代码库以查找类似问题
