# 代码风格

## 不可变性 (关键)

**务必**创建新对象，**绝不**修改原对象：

```javascript
// 错误：修改原对象 (Mutation)
function updateUser(user, name) {
  user.name = name  // 修改了原对象！
  return user
}

// 正确：不可变模式 (Immutability)
function updateUser(user, name) {
  return {
    ...user,
    name
  }
}
```

## 文件组织

**多小文件 > 少大文件**：
- 高内聚，低耦合
- 通常 200-400 行，最多 800 行
- 从大型组件中提取工具函数
- 按特性/领域组织，而非按类型

## 错误处理

**务必**全面处理错误：

```typescript
try {
  const result = await riskyOperation()
  return result
} catch (error) {
  console.error('操作失败:', error)
  throw new Error('详细且友好的错误信息')
}
```

## 输入验证

**务必**验证用户输入：

```typescript
import { z } from 'zod'

const schema = z.object({
  email: z.string().email(),
  age: z.number().int().min(0).max(150)
})

const validated = schema.parse(input)
```

## 代码质量检查清单

在标记工作完成前，请检查：
- [ ] 代码可读性强，命名规范
- [ ] 函数短小 (<50 行)
- [ ] 文件职责单一 (<800 行)
- [ ] 无深层嵌套 (>4 层)
- [ ] 恰当的错误处理
- [ ] 无 console.log 语句
- [ ] 无硬编码值
- [ ] 无状态修改 (使用不可变模式)
