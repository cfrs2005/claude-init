#!/bin/bash
# 战略压缩建议器 (Strategic Compact Suggester)
# 在 PreToolUse 钩子上运行，或定期运行，建议在逻辑间隔点进行手动压缩
#
# 为什么手动压缩优于自动压缩：
# - 自动压缩发生在任意时间点，通常是任务中途
# - 战略压缩通过逻辑阶段保留上下文
# - 在探索之后、执行之前进行压缩
# - 在完成里程碑之后、开始下一个之前进行压缩
#
# 钩子配置 (位于 ~/.claude/settings.json):
# {
#   "hooks": {
#     "PreToolUse": [{
#       "matcher": "Edit|Write",
#       "hooks": [{
#         "type": "command",
#         "command": "~/.claude/skills/strategic-compact/suggest-compact.sh"
#       }]
#     }]
#   }
# }
#
# 建议压缩的标准：
# - 会话已运行较长时间
# - 已进行大量工具调用
# - 正从研究/探索过渡到实现
# - 计划已定稿

# Track tool call count (increment in a temp file)
# 跟踪工具调用计数（在临时文件中递增）
COUNTER_FILE="/tmp/claude-tool-count-$$"
THRESHOLD=${COMPACT_THRESHOLD:-50}

# Initialize or increment counter
# 初始化或递增计数器
if [ -f "$COUNTER_FILE" ]; then
  count=$(cat "$COUNTER_FILE")
  count=$((count + 1))
  echo "$count" > "$COUNTER_FILE"
else
  echo "1" > "$COUNTER_FILE"
  count=1
fi

# Suggest compact after threshold tool calls
# 达到阈值工具调用次数后建议压缩
if [ "$count" -eq "$THRESHOLD" ]; then
  echo "[StrategicCompact] 已达到 $THRESHOLD 次工具调用 - 如果正在进行阶段过渡，请考虑使用 /compact" >&2
fi

# Suggest at regular intervals after threshold
# 针对超过阈值后的定期建议
if [ "$count" -gt "$THRESHOLD" ] && [ $((count % 25)) -eq 0 ]; then
  echo "[StrategicCompact] $count 次工具调用 - 如果上下文陈旧，这是一个使用 /compact 的好检查点" >&2
fi
