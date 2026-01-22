#!/bin/bash
# 持续学习 - 会话评估器
# 在 Stop 钩子上运行，从 Claude Code 会话中提取可重用的模式
#
# 为什么使用 Stop 钩子而不是 UserPromptSubmit：
# - Stop 在会话结束时运行一次（轻量级）
# - UserPromptSubmit 在每条消息时运行（重量级，增加延迟）
#
# 钩子配置 (位于 ~/.claude/settings.json):
# {
#   "hooks": {
#     "Stop": [{
#       "matcher": "*",
#       "hooks": [{
#         "type": "command",
#         "command": "~/.claude/skills/continuous-learning/evaluate-session.sh"
#       }]
#     }]
#   }
# }
#
# 要检测的模式: error_resolution (错误解决), debugging_techniques (调试技巧), workarounds (变通方案), project_specific (项目特定)
# 要忽略的模式: simple_typos (简单拼写错误), one_time_fixes (一次性修复), external_api_issues (外部 API 问题)
# 提取的技能保存至: ~/.claude/skills/learned/

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$SCRIPT_DIR/config.json"
LEARNED_SKILLS_PATH="${HOME}/.claude/skills/learned"
MIN_SESSION_LENGTH=10

# Load config if exists
# 如果存在则加载配置
if [ -f "$CONFIG_FILE" ]; then
  MIN_SESSION_LENGTH=$(jq -r '.min_session_length // 10' "$CONFIG_FILE")
  LEARNED_SKILLS_PATH=$(jq -r '.learned_skills_path // "~/.claude/skills/learned/"' "$CONFIG_FILE" | sed "s|~|$HOME|")
fi

# Ensure learned skills directory exists
# 确保已学习技能目录存在
mkdir -p "$LEARNED_SKILLS_PATH"

# Get transcript path from environment (set by Claude Code)
# 从环境变量获取记录路径（由 Claude Code 设置）
transcript_path="${CLAUDE_TRANSCRIPT_PATH:-}"

if [ -z "$transcript_path" ] || [ ! -f "$transcript_path" ]; then
  exit 0
fi

# Count messages in session
# 统计会话中的消息数
message_count=$(grep -c '"type":"user"' "$transcript_path" 2>/dev/null || echo "0")

# Skip short sessions
# 跳过过短的会话
if [ "$message_count" -lt "$MIN_SESSION_LENGTH" ]; then
  echo "[ContinuousLearning] 会话太短 ($message_count 条消息)，跳过" >&2
  exit 0
fi

# Signal to Claude that session should be evaluated for extractable patterns
# 向 Claude 发出信号，表明应对会话进行评估以提取模式
echo "[ContinuousLearning] 会话包含 $message_count 条消息 - 评估可提取的模式" >&2
echo "[ContinuousLearning] 将学习到的技能保存至: $LEARNED_SKILLS_PATH" >&2
