#!/bin/bash
# 战略压缩建议器 (Strategic Compact Suggester)
# 在 PreToolUse 或定期运行，以在逻辑间隔建议手动压缩
#
# 为什么要手动优于自动压缩:
# - 自动压缩发生在任意时刻，通常在任务中途
# - 战略压缩通过逻辑阶段保留上下文
# - 在探索之后、执行之前压缩
# - 在完成里程碑后、开始下一个之前压缩
#
# Hook 配置 (在 ~/.claude/settings.json):
# {
#   "hooks": {
#     "PreToolUse": [{
#       "matcher": "Edit|Write",
#       "hooks": [{
#         "type": "command",
#         "command": "~/.claude/hooks/strategic-compact/suggest-compact.sh"
#       }]
#     }]
#   }
# }
#
# 建议压缩的标准:
# - 会话已运行较长时间
# - 进行了大量工具调用
# - 正在从调研/探索过渡到实施
# - 计划已定稿

# Track tool call count (increment in a temp file)
COUNTER_FILE="/tmp/claude-tool-count-$$"
THRESHOLD=${COMPACT_THRESHOLD:-50}

# Initialize or increment counter
if [ -f "$COUNTER_FILE" ]; then
  count=$(cat "$COUNTER_FILE")
  count=$((count + 1))
  echo "$count" > "$COUNTER_FILE"
else
  echo "1" > "$COUNTER_FILE"
  count=1
fi

# Suggest compact after threshold tool calls
if [ "$count" -eq "$THRESHOLD" ]; then
  echo "[StrategicCompact] 已达到 $THRESHOLD 次工具调用 - 如果正在过渡阶段，请考虑 /compact" >&2
fi

# Suggest at regular intervals after threshold
if [ "$count" -gt "$THRESHOLD" ] && [ $((count % 25)) -eq 0 ]; then
  echo "[StrategicCompact] 已进行 $count 次工具调用 - 如果上下文已陈旧，这是执行 /compact 的好时机" >&2
fi
