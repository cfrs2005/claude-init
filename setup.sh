#!/usr/bin/env bash

# Claude Code 中文开发套件增强设置脚本
# 包含交互式 MCP 服务器配置

set -euo pipefail

# 颜色定义
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'

# 配置变量
TARGET_DIR="${INSTALLER_ORIGINAL_PWD:-$(pwd)}"
INSTALL_CONTEXT7="n"
INSTALL_GEMINI="n"
INSTALL_NOTIFICATIONS="y"
IS_INTERACTIVE=true

# 检查是否为交互式终端
if [ ! -t 0 ]; then
    IS_INTERACTIVE=false
    # 非交互式模式下的默认配置
    INSTALL_CONTEXT7="y"
    INSTALL_GEMINI="y"
    INSTALL_NOTIFICATIONS="y"
fi

print_color() {
    local color=$1
    shift
    echo -e "${color}$@${NC}"
}

# 安全读取函数（适配非交互模式）
safe_read_yn() {
    local var_name="$1"
    local prompt="$2"
    local default="${3:-n}"
    
    if [ "$IS_INTERACTIVE" = false ]; then
        eval "$var_name=\"$default\""
        return 0
    fi
    
    local response
    while true; do
        echo -n "$prompt"
        read response
        case "${response,,}" in
            y|yes|是|y*)
                eval "$var_name=\"y\""
                return 0
                ;;
            n|no|否|n*|"")
                eval "$var_name=\"n\""
                return 0
                ;;
            *)
                print_color "$YELLOW" "请输入 y/yes/是 或 n/no/否"
                ;;
        esac
    done
}

print_header() {
    echo
    print_color "$BLUE" "==========================================="
    print_color "$BLUE" "   Claude Code 中文开发套件设置"
    print_color "$BLUE" "==========================================="
    echo
}

# 询问可选组件
prompt_optional_components() {
    if [ "$IS_INTERACTIVE" = false ]; then
        print_color "$CYAN" "🤖 非交互模式：启用所有 MCP 功能"
        return 0
    fi
    
    echo
    print_color "$YELLOW" "可选组件配置："
    echo
    
    # Context7 MCP
    print_color "$CYAN" "Context7 MCP 服务器（强烈推荐）"
    echo "  为外部库提供最新文档支持（React、FastAPI 等）"
    echo "  仓库：https://github.com/upstash/context7"
    if ! safe_read_yn INSTALL_CONTEXT7 "  安装 Context7 集成？(y/n): " "y"; then
        exit 1
    fi
    echo
    
    # Gemini MCP
    print_color "$CYAN" "Gemini 助手 MCP 服务器（强烈推荐）"
    echo "  启用架构咨询和高级代码审查功能"
    echo "  仓库：https://github.com/jamubc/gemini-mcp-tool"
    if ! safe_read_yn INSTALL_GEMINI "  安装 Gemini 集成？(y/n): " "y"; then
        exit 1
    fi
    echo
    
    # 通知系统
    print_color "$CYAN" "通知系统（便利功能）"
    echo "  任务完成或需要输入时播放音频提醒"
    if ! safe_read_yn INSTALL_NOTIFICATIONS "  设置通知 Hook？(y/n): " "y"; then
        exit 1
    fi
}

# 生成 settings.local.json 配置
generate_settings() {
    local config_file="$TARGET_DIR/.claude/settings.local.json"
    mkdir -p "$(dirname "$config_file")"
    
    print_color "$YELLOW" "🔧 正在生成配置文件..."
    
    # 构建配置
    cat > "$config_file" << 'EOF'
{
  "hooks": {
EOF

    # PreToolUse hooks
    local pretooluse_hooks=()
    
    # MCP 安全扫描
    if [ "$INSTALL_CONTEXT7" = "y" ] || [ "$INSTALL_GEMINI" = "y" ]; then
        pretooluse_hooks+=("mcp-security")
    fi
    
    # Gemini 上下文注入
    if [ "$INSTALL_GEMINI" = "y" ]; then
        pretooluse_hooks+=("gemini-context")
    fi
    
    # 子智能体上下文注入（核心功能）
    pretooluse_hooks+=("subagent-context")
    
    # 写入 PreToolUse hooks
    if [ ${#pretooluse_hooks[@]} -gt 0 ]; then
        cat >> "$config_file" << 'EOF'
    "PreToolUse": [
EOF
        
        local first_hook=true
        
        # MCP 安全扫描
        if [[ " ${pretooluse_hooks[@]} " =~ " mcp-security " ]]; then
            [ "$first_hook" = false ] && echo "," >> "$config_file"
            cat >> "$config_file" << EOF
      {
        "matcher": "mcp__",
        "hooks": [
          {
            "type": "command",
            "command": "bash $TARGET_DIR/.claude/hooks/mcp-security-scan.sh"
          }
        ]
      }
EOF
            first_hook=false
        fi
        
        # Gemini 上下文注入
        if [[ " ${pretooluse_hooks[@]} " =~ " gemini-context " ]]; then
            [ "$first_hook" = false ] && echo "," >> "$config_file"
            cat >> "$config_file" << EOF
      {
        "matcher": "mcp__gemini",
        "hooks": [
          {
            "type": "command",
            "command": "bash $TARGET_DIR/.claude/hooks/gemini-context-injector.sh"
          }
        ]
      }
EOF
            first_hook=false
        fi
        
        # 子智能体上下文注入
        if [[ " ${pretooluse_hooks[@]} " =~ " subagent-context " ]]; then
            [ "$first_hook" = false ] && echo "," >> "$config_file"
            cat >> "$config_file" << EOF
      {
        "matcher": "Task",
        "hooks": [
          {
            "type": "command",
            "command": "bash $TARGET_DIR/.claude/hooks/subagent-context-injector.sh"
          }
        ]
      }
EOF
        fi
        
        cat >> "$config_file" << 'EOF'
    ]
EOF
    fi
    
    # 通知 hooks
    if [ "$INSTALL_NOTIFICATIONS" = "y" ]; then
        # 如果有 PreToolUse hooks，添加逗号
        if [ ${#pretooluse_hooks[@]} -gt 0 ]; then
            echo "," >> "$config_file"
        fi
        
        cat >> "$config_file" << EOF
    "Notification": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "bash $TARGET_DIR/.claude/hooks/notify.sh input"
          }
        ]
      }
    ],
    "Stop": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "bash $TARGET_DIR/.claude/hooks/notify.sh complete"
          }
        ]
      }
    ]
EOF
    fi
    
    # 结束 hooks 对象
    cat >> "$config_file" << 'EOF'
  },
EOF
    
    # 结束整个配置文件（MCP 服务器已移至项目级配置）
    cat >> "$config_file" << 'EOF'
}
EOF
    
    print_color "$GREEN" "✅ 配置已生成：$config_file"
}

# 安装 MCP 服务器（使用新的项目级安装方法）
install_mcp_servers() {
    if [ "$INSTALL_CONTEXT7" = "y" ] || [ "$INSTALL_GEMINI" = "y" ]; then
        echo
        print_color "$CYAN" "📡 正在安装 MCP 服务器（项目级）..."
        
        # 切换到目标目录进行安装
        cd "$TARGET_DIR"
        
        if [ "$INSTALL_CONTEXT7" = "y" ]; then
            print_color "$YELLOW" "📚 正在安装 Context7 MCP 服务器..."
            if claude mcp add context7 --scope project -- npx -y @upstash/context7-mcp --api-key YOUR_CONTEXT7_API_KEY 2>/dev/null; then
                print_color "$GREEN" "  ✅ Context7 MCP 服务器已安装（项目级）"
            else
                print_color "$YELLOW" "  ⚠️  Context7 安装失败，请手动运行：claude mcp add context7 --scope project -- npx -y @upstash/context7-mcp --api-key YOUR_CONTEXT7_API_KEY"
            fi
        fi
        
        if [ "$INSTALL_GEMINI" = "y" ]; then
            print_color "$YELLOW" "🧠 正在安装 Gemini MCP 服务器..."
            if claude mcp add gemini --scope project -- npx -y gemini-mcp --api-key YOUR_GEMINI_API_KEY 2>/dev/null; then
                print_color "$GREEN" "  ✅ Gemini MCP 服务器已安装（项目级）"
            else
                print_color "$YELLOW" "  ⚠️  Gemini 安装失败，请手动运行：claude mcp add gemini --scope project -- npx -y gemini-mcp --api-key YOUR_GEMINI_API_KEY"
            fi
        fi
        
        print_color "$GREEN" "✅ MCP 服务器配置完成！配置已保存到 .mcp.json"
    fi
}

# 显示 MCP 服务器信息
display_mcp_info() {
    if [ "$INSTALL_CONTEXT7" = "y" ] || [ "$INSTALL_GEMINI" = "y" ]; then
        echo
        print_color "$BLUE" "=== MCP 服务器设置信息 ==="
        echo
        print_color "$GREEN" "✅ MCP 服务器已配置为项目级安装！"
        echo
        echo "配置的服务器："
        
        if [ "$INSTALL_CONTEXT7" = "y" ]; then
            print_color "$YELLOW" "📚 Context7 MCP 服务器："
            echo "  • 提供最新外部库文档"
            echo "  • 支持 React、FastAPI、Next.js 等"
            echo "  • 使用方法：mcp__context7__get_library_docs"
            echo
        fi
        
        if [ "$INSTALL_GEMINI" = "y" ]; then
            print_color "$YELLOW" "🧠 Gemini MCP 服务器："
            echo "  • 深度架构咨询"
            echo "  • 高级代码审查"
            echo "  • 使用方法：mcp__gemini__consult_gemini"
            echo
        fi
        
        print_color "$CYAN" "💡 重要配置提醒："
        echo "  • MCP 服务器已安装为项目级配置"
        echo "  • 配置文件：.mcp.json（在项目根目录）"
        echo "  • 需要将占位符 API 密钥替换为真实密钥："
        echo "    - YOUR_CONTEXT7_API_KEY → 你的 Context7 API 密钥"  
        echo "    - YOUR_GEMINI_API_KEY → 你的 Gemini API 密钥"
        echo "  • API 密钥获取方式请参考各服务官方文档"
        echo "  • 项目级配置仅在此项目目录中生效"
    fi
}

# 主安装流程
main() {
    print_header
    print_color "$CYAN" "🎯 目标目录: $TARGET_DIR"
    
    # 检查目录权限
    if [ ! -w "$TARGET_DIR" ]; then
        print_color "$RED" "❌ 无法写入目标目录: $TARGET_DIR"
        exit 1
    fi
    
    # 询问可选组件
    prompt_optional_components
    
    echo
    print_color "$YELLOW" "📄 正在复制中文化模板文件..."
    
    # 复制 CLAUDE.md
    if [ -f "templates/CLAUDE.md" ]; then
        cp "templates/CLAUDE.md" "$TARGET_DIR/" 2>/dev/null || {
            print_color "$YELLOW" "⚠️  CLAUDE.md 已存在，跳过复制"
        }
        print_color "$GREEN" "  ✅ CLAUDE.md (主 AI 上下文文件)"
    fi
    
    # 复制 MCP 规则
    if [ -f "templates/MCP-ASSISTANT-RULES.md" ]; then
        cp "templates/MCP-ASSISTANT-RULES.md" "$TARGET_DIR/" 2>/dev/null || {
            print_color "$YELLOW" "⚠️  MCP-ASSISTANT-RULES.md 已存在，跳过复制"
        }
        print_color "$GREEN" "  ✅ MCP-ASSISTANT-RULES.md (MCP 助手规则)"
    fi
    
    # 复制文档文件
    if [ -d "templates/docs" ]; then
        mkdir -p "$TARGET_DIR/docs/ai-context"
        find "templates/docs" -type f -name "*.md" | while read -r file; do
            rel_path="${file#templates/docs/}"
            target_file="$TARGET_DIR/docs/$rel_path"
            mkdir -p "$(dirname "$target_file")"
            if [ ! -f "$target_file" ]; then
                cp "$file" "$target_file"
            fi
        done
        print_color "$GREEN" "  ✅ docs/ (中文文档系统)"
    fi
    
    # 复制 .claude 目录
    if [ -d "templates/.claude" ]; then
        # 复制 commands
        if [ -d "templates/.claude/commands" ]; then
            mkdir -p "$TARGET_DIR/.claude/commands"
            cp -r "templates/.claude/commands/"* "$TARGET_DIR/.claude/commands/" 2>/dev/null || true
            print_color "$GREEN" "  ✅ .claude/commands/ (Claude Code 命令集)"
        fi
        
        # 复制 hooks
        if [ -d "templates/.claude/hooks" ]; then
            mkdir -p "$TARGET_DIR/.claude/hooks"
            cp -r "templates/.claude/hooks/"* "$TARGET_DIR/.claude/hooks/" 2>/dev/null || true
            chmod +x "$TARGET_DIR/.claude/hooks/"*.sh 2>/dev/null || true
            print_color "$GREEN" "  ✅ .claude/hooks/ (中文化 Hook 脚本和配置)"
        fi
    fi
    
    # 复制示例
    if [ -d "examples" ]; then
        mkdir -p "$TARGET_DIR/examples"
        cp -r "examples/"* "$TARGET_DIR/examples/" 2>/dev/null || true
        print_color "$GREEN" "  ✅ examples/ (中文使用示例)"
    fi
    
    echo
    print_color "$CYAN" "🔧 正在生成项目配置..."
    
    # 生成配置文件
    generate_settings
    
    # 安装 MCP 服务器（新的项目级方法）
    install_mcp_servers
    
    # 显示 MCP 信息
    display_mcp_info
    
    echo
    print_color "$GREEN" "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    print_color "$GREEN" "🎉 Claude Code 中文开发套件设置完成！"
    print_color "$GREEN" "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    echo
    print_color "$CYAN" "📖 下一步："
    echo "  1. 查看 CLAUDE.md 了解中文化的 AI 指令"
    echo "  2. 阅读 docs/README.md 学习文档系统"
    echo "  3. 参考 examples/ 目录中的使用示例"
    
    if [ "$INSTALL_GEMINI" = "y" ]; then
        echo "  4. 编辑 MCP-ASSISTANT-RULES.md 设置 Gemini 编码标准"
    fi
    
    echo "  $([ "$INSTALL_GEMINI" = "y" ] && echo 5 || echo 4). 运行 'claude' 开始你的中文开发之旅！"
    echo
    
    # MCP 服务器配置指导
    if [ "$INSTALL_CONTEXT7" = "y" ] || [ "$INSTALL_GEMINI" = "y" ]; then
        echo
        print_color "$CYAN" "📡 MCP 服务器配置完成："
        echo
        print_color "$YELLOW" "下一步配置："
        echo "  1. 编辑 .mcp.json 文件，将占位符 API 密钥替换为真实密钥"
        echo "  2. Context7 API 密钥：https://context7.com/"
        echo "  3. Gemini API 密钥：https://makersuite.google.com/app/apikey"
        echo
        print_color "$YELLOW" "验证 MCP 服务器状态："
        echo "  claude mcp list"
        echo
        print_color "$YELLOW" "💡 MCP 服务器已配置为项目级，仅在此目录中生效！"
    fi
}

# 运行主函数
main "$@"