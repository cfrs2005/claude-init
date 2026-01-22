---
name: coding-standards
description: 适用于 TypeScript、JavaScript、React 和 Node.js 开发的通用编码标准、最佳实践和模式。
---

# 编码标准与最佳实践

适用于所有项目的通用编码标准。

## 代码质量原则

### 1. 可读性优先 (Readability First)
- 代码被阅读的次数远多于被编写的次数
- 变量和函数命名要清晰
- 优先编写自文档化的代码，而非依赖注释
- 保持格式一致

### 2. KISS (Keep It Simple, Stupid)
- 采用最简单的有效方案
- 避免过度工程化
- 禁止过早优化
- 易于理解 > 巧妙的代码

### 3. DRY (Don't Repeat Yourself)
- 将通用逻辑提取为函数
- 创建可复用的组件
- 在模块间共享工具库
- 避免复制粘贴编程

### 4. YAGNI (You Aren't Gonna Need It)
- 不要构建暂不需要的功能
- 避免推测性的通用性
- 仅在需要时增加复杂性
- 从简单开始，按需重构

## TypeScript/JavaScript 标准

### 变量命名

```typescript
// ✅ GOOD: 描述性命名
const marketSearchQuery = 'election'
const isUserAuthenticated = true
const totalRevenue = 1000

// ❌ BAD: 含义不明的命名
const q = 'election'
const flag = true
const x = 1000
```

### 函数命名

```typescript
// ✅ GOOD: 动词-名词模式
async function fetchMarketData(marketId: string) { }
function calculateSimilarity(a: number[], b: number[]) { }
function isValidEmail(email: string): boolean { }

// ❌ BAD: 含义不明或仅使用名词
async function market(id: string) { }
function similarity(a, b) { }
function email(e) { }
```

### 不可变模式 (CRITICAL)

```typescript
// ✅ 务必使用展开运算符
const updatedUser = {
  ...user,
  name: 'New Name'
}

const updatedArray = [...items, newItem]

// ❌ 严禁直接修改
user.name = 'New Name'  // BAD
items.push(newItem)     // BAD
```

### 错误处理

```typescript
// ✅ GOOD: 全面的错误处理
async function fetchData(url: string) {
  try {
    const response = await fetch(url)

    if (!response.ok) {
      throw new Error(`HTTP ${response.status}: ${response.statusText}`)
    }

    return await response.json()
  } catch (error) {
    console.error('获取失败 (Fetch failed):', error)
    throw new Error('获取数据失败 (Failed to fetch data)')
  }
}

// ❌ BAD: 无错误处理
async function fetchData(url) {
  const response = await fetch(url)
  return response.json()
}
```

### Async/Await 最佳实践

```typescript
// ✅ GOOD: 尽可能并行执行
const [users, markets, stats] = await Promise.all([
  fetchUsers(),
  fetchMarkets(),
  fetchStats()
])

// ❌ BAD: 不必要的串行执行
const users = await fetchUsers()
const markets = await fetchMarkets()
const stats = await fetchStats()
```

### 类型安全

```typescript
// ✅ GOOD: 恰当的类型定义
interface Market {
  id: string
  name: string
  status: 'active' | 'resolved' | 'closed'
  created_at: Date
}

function getMarket(id: string): Promise<Market> {
  // 实现
}

// ❌ BAD: 使用 'any'
function getMarket(id: any): Promise<any> {
  // 实现
}
```

## React 最佳实践

### 组件结构

```typescript
// ✅ GOOD: 带类型的函数组件
interface ButtonProps {
  children: React.ReactNode
  onClick: () => void
  disabled?: boolean
  variant?: 'primary' | 'secondary'
}

export function Button({
  children,
  onClick,
  disabled = false,
  variant = 'primary'
}: ButtonProps) {
  return (
    <button
      onClick={onClick}
      disabled={disabled}
      className={`btn btn-${variant}`}
    >
      {children}
    </button>
  )
}

// ❌ BAD: 无类型，结构不清
export function Button(props) {
  return <button onClick={props.onClick}>{props.children}</button>
}
```

### 自定义 Hook

```typescript
// ✅ GOOD: 可复用的自定义 hook
export function useDebounce<T>(value: T, delay: number): T {
  const [debouncedValue, setDebouncedValue] = useState<T>(value)

  useEffect(() => {
    const handler = setTimeout(() => {
      setDebouncedValue(value)
    }, delay)

    return () => clearTimeout(handler)
  }, [value, delay])

  return debouncedValue
}

// 用法
const debouncedQuery = useDebounce(searchQuery, 500)
```

### 状态管理

```typescript
// ✅ GOOD: 正确的状态更新
const [count, setCount] = useState(0)

// 基于前一个状态的函数式更新
setCount(prev => prev + 1)

// ❌ BAD: 直接引用状态
setCount(count + 1)  // 在异步场景中可能已过时
```

### 条件渲染

```typescript
// ✅ GOOD: 清晰的条件渲染
{isLoading && <Spinner />}
{error && <ErrorMessage error={error} />}
{data && <DataDisplay data={data} />}

// ❌ BAD: 三元表达式地狱
{isLoading ? <Spinner /> : error ? <ErrorMessage error={error} /> : data ? <DataDisplay data={data} /> : null}
```

## API 设计标准

### REST API 约定

```
GET    /api/markets              # 列出所有市场
GET    /api/markets/:id          # 获取特定市场
POST   /api/markets              # 创建新市场
PUT    /api/markets/:id          # 更新市场 (全量)
PATCH  /api/markets/:id          # 更新市场 (部分)
DELETE /api/markets/:id          # 删除市场

# 用于过滤的查询参数
GET /api/markets?status=active&limit=10&offset=0
```

### 响应格式

```typescript
// ✅ GOOD: 一致的响应结构
interface ApiResponse<T> {
  success: boolean
  data?: T
  error?: string
  meta?: {
    total: number
    page: number
    limit: number
  }
}

// 成功响应
return NextResponse.json({
  success: true,
  data: markets,
  meta: { total: 100, page: 1, limit: 10 }
})

// 错误响应
return NextResponse.json({
  success: false,
  error: '无效请求 (Invalid request)'
}, { status: 400 })
```

### 输入验证

```typescript
import { z } from 'zod'

// ✅ GOOD: Schema 验证
const CreateMarketSchema = z.object({
  name: z.string().min(1).max(200),
  description: z.string().min(1).max(2000),
  endDate: z.string().datetime(),
  categories: z.array(z.string()).min(1)
})

export async function POST(request: Request) {
  const body = await request.json()

  try {
    const validated = CreateMarketSchema.parse(body)
    // 继续使用验证后的数据
  } catch (error) {
    if (error instanceof z.ZodError) {
      return NextResponse.json({
        success: false,
        error: '验证失败 (Validation failed)',
        details: error.errors
      }, { status: 400 })
    }
  }
}
```

## 文件组织

### 项目结构

```
src/
├── app/                    # Next.js App Router
│   ├── api/               # API 路由
│   ├── markets/           # 市场页面
│   └── (auth)/           # 认证页面 (路由组)
├── components/            # React 组件
│   ├── ui/               # 通用 UI 组件
│   ├── forms/            # 表单组件
│   └── layouts/          # 布局组件
├── hooks/                # 自定义 React hooks
├── lib/                  # 工具函数与配置
│   ├── api/             # API 客户端
│   ├── utils/           # 辅助函数
│   └── constants/       # 常量
├── types/                # TypeScript 类型
└── styles/              # 全局样式
```

### 文件命名

```
components/Button.tsx          # 组件使用帕斯卡命名法 (PascalCase)
hooks/useAuth.ts              # hook 使用 'use' 前缀的小驼峰命名法 (camelCase)
lib/formatDate.ts             # 工具函数使用小驼峰命名法 (camelCase)
types/market.types.ts         # 类型文件使用 .types 后缀的小驼峰命名法 (camelCase)
```

## 注释与文档

### 何时注释

```typescript
// ✅ GOOD: 解释"为什么" (WHY)，而不是"做什么" (WHAT)
// 使用指数退避以避免在故障期间压垮 API
const delay = Math.min(1000 * Math.pow(2, retryCount), 30000)

// 出于处理大数组时的性能考虑，此处特意使用可变操作
items.push(newItem)

// ❌ BAD: 陈述显而易见的事实
// 计数器加 1
count++

// 将 name 设置为用户的名字
name = user.name
```

### 公共 API 的 JSDoc

```typescript
/**
 * 使用语义相似度搜索市场。
 *
 * @param query - 自然语言搜索查询
 * @param limit - 最大结果数 (默认为 10)
 * @returns 按相似度得分排序的市场数组
 * @throws {Error} 如果 OpenAI API 失败或 Redis 不可用
 *
 * @example
 * ```typescript
 * const results = await searchMarkets('election', 5)
 * console.log(results[0].name) // "Trump vs Biden"
 * ```
 */
export async function searchMarkets(
  query: string,
  limit: number = 10
): Promise<Market[]> {
  // 实现
}
```

## 性能最佳实践

### 记忆化 (Memoization)

```typescript
import { useMemo, useCallback } from 'react'

// ✅ GOOD: 记忆化昂贵的计算
const sortedMarkets = useMemo(() => {
  return markets.sort((a, b) => b.volume - a.volume)
}, [markets])

// ✅ GOOD: 记忆化回调函数
const handleSearch = useCallback((query: string) => {
  setSearchQuery(query)
}, [])
```

### 懒加载 (Lazy Loading)

```typescript
import { lazy, Suspense } from 'react'

// ✅ GOOD: 懒加载沉重的组件
const HeavyChart = lazy(() => import('./HeavyChart'))

export function Dashboard() {
  return (
    <Suspense fallback={<Spinner />}>
      <HeavyChart />
    </Suspense>
  )
}
```

### 数据库查询

```typescript
// ✅ GOOD: 仅选择所需列
const { data } = await supabase
  .from('markets')
  .select('id, name, status')
  .limit(10)

// ❌ BAD: 选择所有列
const { data } = await supabase
  .from('markets')
  .select('*')
```

## 测试标准

### 测试结构 (AAA 模式)

```typescript
test('calculates similarity correctly', () => {
  // Arrange (准备)
  const vector1 = [1, 0, 0]
  const vector2 = [0, 1, 0]

  // Act (执行)
  const similarity = calculateCosineSimilarity(vector1, vector2)

  // Assert (断言)
  expect(similarity).toBe(0)
})
```

### 测试命名

```typescript
// ✅ GOOD: 描述性测试名称
test('returns empty array when no markets match query', () => { })
test('throws error when OpenAI API key is missing', () => { })
test('falls back to substring search when Redis unavailable', () => { })

// ❌ BAD: 模糊的测试名称
test('works', () => { })
test('test search', () => { })
```

## 代码异味检测

请警惕以下反模式：

### 1. 过长函数
```typescript
// ❌ BAD: 函数超过 50 行
function processMarketData() {
  // 100 行代码
}

// ✅ GOOD: 拆分为更小的函数
function processMarketData() {
  const validated = validateData()
  const transformed = transformData(validated)
  return saveData(transformed)
}
```

### 2. 深度嵌套
```typescript
// ❌ BAD: 超过 5 层嵌套
if (user) {
  if (user.isAdmin) {
    if (market) {
      if (market.isActive) {
        if (hasPermission) {
          // 做些什么
        }
      }
    }
  }
}

// ✅ GOOD: 提前返回 (Early returns)
if (!user) return
if (!user.isAdmin) return
if (!market) return
if (!market.isActive) return
if (!hasPermission) return

// 做些什么
```

### 3. 魔术数字
```typescript
// ❌ BAD: 未解释的数字
if (retryCount > 3) { }
setTimeout(callback, 500)

// ✅ GOOD: 具名常量
const MAX_RETRIES = 3
const DEBOUNCE_DELAY_MS = 500

if (retryCount > MAX_RETRIES) { }
setTimeout(callback, DEBOUNCE_DELAY_MS)
```

**记住**：代码质量不容妥协。清晰、可维护的代码是快速开发和自信重构的基石。
