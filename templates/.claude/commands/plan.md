---
description: 重述需求，评估风险，并创建分步实施计划。在触碰任何代码前，必须等待用户确认。
---

# 计划指令 (Plan Command)

此指令调用 **规划师 (planner)** 智能体，在编写任何代码之前创建一个全面的实施计划。

## 此指令的功能

1. **重述需求** - 厘清需要构建什么
2. **识别风险** - 暴露潜在问题和阻碍
3. **制定分步计划** - 将实施过程分解为若干阶段
4. **等待确认** - 在继续之前 **必须** 获得用户的批准

## 何时使用

在以下情况使用 `/plan`：
- 开始新功能开发时
- 进行重大架构变更时
- 处理复杂的重构工作时
- 涉及多个文件/组件的变更时
- 需求不明确或模棱两可时

## 工作原理

规划师智能体将：

1. **分析请求** 并用清晰的术语重述需求
2. **分解阶段** 为具体、可执行的步骤
3. **识别依赖** 组件之间的关系
4. **评估风险** 及潜在的阻碍因素
5. **预估复杂度** (高/中/低)
6. **展示计划** 并 **等待** 你的明确确认

## 使用示例

```
User: /plan I need to add real-time notifications when markets resolve
(用户：/plan 我需要在市场结算时添加实时通知)

Agent (planner):
# Implementation Plan: Real-Time Market Resolution Notifications
(实施计划：实时市场结算通知)

## Requirements Restatement (需求重述)
- Send notifications to users when markets they're watching resolve (当用户关注的市场结算时发送通知)
- Support multiple notification channels (in-app, email, webhook) (支持多种通知渠道：应用内、邮件、Webhook)
- Ensure notifications are delivered reliably (确保通知可靠送达)
- Include market outcome and user's position result (包含市场结果和用户持仓结果)

## Implementation Phases (实施阶段)

### Phase 1: Database Schema (阶段 1：数据库架构)
- Add notifications table with columns: id, user_id, market_id, type, status, created_at
- Add user_notification_preferences table for channel preferences
- Create indexes on user_id and market_id for performance

### Phase 2: Notification Service (阶段 2：通知服务)
- Create notification service in lib/notifications.ts
- Implement notification queue using BullMQ/Redis
- Add retry logic for failed deliveries
- Create notification templates

### Phase 3: Integration Points (阶段 3：集成点)
- Hook into market resolution logic (when status changes to "resolved")
- Query all users with positions in market
- Enqueue notifications for each user

### Phase 4: Frontend Components (阶段 4：前端组件)
- Create NotificationBell component in header
- Add NotificationList modal
- Implement real-time updates via Supabase subscriptions
- Add notification preferences page

## Dependencies (依赖)
- Redis (for queue)
- Email service (SendGrid/Resend)
- Supabase real-time subscriptions

## Risks (风险)
- HIGH: Email deliverability (SPF/DKIM required)
- MEDIUM: Performance with 1000+ users per market
- MEDIUM: Notification spam if markets resolve frequently
- LOW: Real-time subscription overhead

## Estimated Complexity: MEDIUM (预估复杂度：中等)
- Backend: 4-6 hours
- Frontend: 3-4 hours
- Testing: 2-3 hours
- Total: 9-13 hours

**WAITING FOR CONFIRMATION**: Proceed with this plan? (yes/no/modify)
(等待确认：是否按此计划进行？yes/no/modify)
```

## 重要提示

**关键**：规划师智能体在得到你明确的“yes”或“proceed”（继续）或类似的肯定回复之前，**不会**编写任何代码。

如果你想要修改，请回复：
- "modify: [你的修改意见]"
- "different approach: [替代方案]"
- "skip phase 2 and do phase 3 first" (跳过阶段 2，先做阶段 3)

## 与其他指令的集成

计划完成后：
- 使用 `/tdd` 进行测试驱动开发
- 如果出现构建错误，使用 `/build-and-fix`
- 使用 `/code-review` 审查完成的实现

## 相关智能体

此指令调用位于以下位置的 `planner` 智能体：
`~/.claude/agents/planner.md`
