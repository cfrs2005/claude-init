#!/bin/bash
# Stop Hook (Session End) - 会话结束时持久化学习内容
#
# 当 Claude 会话结束时运行。创建/更新会话日志文件
# 并带有时间戳以进行连续性跟踪。
#
# Hook 配置 (在 ~/.claude/settings.json):
# {
#   "hooks": {
#     "Stop": [{
#       "matcher": "*",
#       "hooks": [{
#         "type": "command",
#         "command": "~/.claude/hooks/memory-persistence/session-end.sh"
#       }]
#     }]
#   }
# }

SESSIONS_DIR="${HOME}/.claude/sessions"
TODAY=$(date '+%Y-%m-%d')
SESSION_FILE="${SESSIONS_DIR}/${TODAY}-session.tmp"

mkdir -p "$SESSIONS_DIR"

# If session file exists for today, update the end time
if [ -f "$SESSION_FILE" ]; then
  # Update Last Updated timestamp
  sed -i '' "s/\*\*Last Updated:\*\*.*/\*\*Last Updated:\*\* $(date '+%H:%M')/" "$SESSION_FILE" 2>/dev/null || \
  sed -i "s/\*\*Last Updated:\*\*.*/\*\*Last Updated:\*\* $(date '+%H:%M')/" "$SESSION_FILE" 2>/dev/null
  echo "[SessionEnd] 已更新会话文件: $SESSION_FILE" >&2
else
  # Create new session file with template
  cat > "$SESSION_FILE" << EOF
# 会话: $(date '+%Y-%m-%d')
**日期:** $TODAY
**开始时间:** $(date '+%H:%M')
**最后更新:** $(date '+%H:%M')

---

## 当前状态

[在此处填写会话上下文]

### 已完成
- [ ]

### 进行中
- [ ]

### 下次会话备注
-

### 需加载的上下文
\`\`\`
[相关文件]
\`\`\`
EOF
  echo "[SessionEnd] 已创建会话文件: $SESSION_FILE" >&2
fi
