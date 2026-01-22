#!/bin/bash
# PreCompact Hook - 在上下文压缩前保存状态
#
# 在 Claude 压缩上下文之前运行，让你有机会
# 保存可能在总结中丢失的重要状态。
#
# Hook 配置 (在 ~/.claude/settings.json):
# {
#   "hooks": {
#     "PreCompact": [{
#       "matcher": "*",
#       "hooks": [{
#         "type": "command",
#         "command": "~/.claude/hooks/memory-persistence/pre-compact.sh"
#       }]
#     }]
#   }
# }

SESSIONS_DIR="${HOME}/.claude/sessions"
COMPACTION_LOG="${SESSIONS_DIR}/compaction-log.txt"

mkdir -p "$SESSIONS_DIR"

# Log compaction event with timestamp
echo "[$(date '+%Y-%m-%d %H:%M:%S')] 触发上下文压缩" >> "$COMPACTION_LOG"

# If there's an active session file, note the compaction
ACTIVE_SESSION=$(ls -t "$SESSIONS_DIR"/*.tmp 2>/dev/null | head -1)
if [ -n "$ACTIVE_SESSION" ]; then
  echo "" >> "$ACTIVE_SESSION"
  echo "---" >> "$ACTIVE_SESSION"
  echo "**[压缩发生于 $(date '+%H:%M')]** - 上下文已被总结" >> "$ACTIVE_SESSION"
fi

echo "[PreCompact] 压缩前状态已保存" >&2
