#!/usr/bin/env pwsh

# Claude Code 中文开发套件增强设置脚本 (PowerShell 版本)
# 包含交互式 MCP 服务器配置

[CmdletBinding()]
param()

# 配置变量
$TargetDir = if ($env:INSTALLER_ORIGINAL_PWD) { $env:INSTALLER_ORIGINAL_PWD } else { Get-Location }
# 默认安装所有 MCP 服务器
$InstallContext7 = $true
$InstallGemini = $true
$InstallNotifications = $true

# 颜色输出函数
function Write-ColoredOutput {
    param(
        [string]$Color,
        [string]$Message
    )
    
    $colors = @{
        'Blue'    = '[34m'
        'Green'   = '[32m'
        'Yellow'  = '[33m'
        'Red'     = '[31m'
        'Cyan'    = '[36m'
        'Reset'   = '[0m'
    }
    
    if ($colors.ContainsKey($Color)) {
        Write-Host "$($colors[$Color])$Message$($colors['Reset'])"
    } else {
        Write-Host $Message
    }
}

# 显示标题
function Show-Header {
    Write-Host ""
    Write-ColoredOutput "Blue" "==========================================="
    Write-ColoredOutput "Blue" "   Claude Code 中文开发套件设置"
    Write-ColoredOutput "Blue" "==========================================="
    Write-Host ""
}

# 询问可选组件
function Prompt-OptionalComponents {
    Write-ColoredOutput "Cyan" "🚀 默认安装所有 MCP 功能和通知系统"
    return $true
}

# 生成 settings.local.json 配置
function Generate-Settings {
    $configFile = Join-Path $TargetDir ".claude/settings.local.json"
    $configDir = Split-Path $configFile -Parent
    
    if (!(Test-Path $configDir)) {
        New-Item -ItemType Directory -Path $configDir -Force | Out-Null
    }
    
    Write-ColoredOutput "Yellow" "🔧 正在生成配置文件..."
    
    # 构建 JSON 配置
    $config = @{
        hooks = @{}
    }
    
    # PreToolUse hooks
    $preToolUseHooks = @()
    
    # MCP 安全扫描
    if ($InstallContext7 -or $InstallGemini) {
        $preToolUseHooks += "mcp-security"
    }
    
    # Gemini 上下文注入
    if ($InstallGemini) {
        $preToolUseHooks += "gemini-context"
    }
    
    # 子智能体上下文注入（核心功能）
    $preToolUseHooks += "subagent-context"
    
    # 构建 PreToolUse hooks
    if ($preToolUseHooks.Count -gt 0) {
        $hookConfigs = @()
        
        # MCP 安全扫描
        if ($preToolUseHooks -contains "mcp-security") {
            $hookConfigs += @{
                matcher = "mcp__"
                hooks = @(
                    @{
                        type = "command"
                        command = "bash $TargetDir/.claude/hooks/mcp-security-scan.sh"
                    }
                )
            }
        }
        
        # Gemini 上下文注入
        if ($preToolUseHooks -contains "gemini-context") {
            $hookConfigs += @{
                matcher = "mcp__gemini"
                hooks = @(
                    @{
                        type = "command"
                        command = "bash $TargetDir/.claude/hooks/gemini-context-injector.sh"
                    }
                )
            }
        }
        
        # 子智能体上下文注入
        if ($preToolUseHooks -contains "subagent-context") {
            $hookConfigs += @{
                matcher = "Task"
                hooks = @(
                    @{
                        type = "command"
                        command = "bash $TargetDir/.claude/hooks/subagent-context-injector.sh"
                    }
                )
            }
        }
        
        $config.hooks.PreToolUse = $hookConfigs
    }
    
    # 通知 hooks
    if ($InstallNotifications) {
        $config.hooks.Notification = @(
            @{
                matcher = ""
                hooks = @(
                    @{
                        type = "command"
                        command = "bash $TargetDir/.claude/hooks/notify.sh input"
                    }
                )
            }
        )
        
        $config.hooks.Stop = @(
            @{
                matcher = ""
                hooks = @(
                    @{
                        type = "command"
                        command = "bash $TargetDir/.claude/hooks/notify.sh complete"
                    }
                )
            }
        )
    }
    
    # MCP 服务器配置
    $mcpServers = @{}
    
    if ($InstallContext7) {
        $mcpServers.context7 = @{
            command = "npx"
            args = @("-y", "@upstash/context7-mcp", "--api-key", "YOUR_CONTEXT7_API_KEY")
        }
    }
    
    if ($InstallGemini) {
        $mcpServers."gemini-mcp-tool" = @{
            command = "npx"
            args = @("-y", "gemini-mcp-tool")
        }
    }
    
    if ($mcpServers.Count -gt 0) {
        $config.mcpServers = $mcpServers
    }
    
    # 转换为 JSON 并保存
    $jsonContent = $config | ConvertTo-Json -Depth 10
    $jsonContent | Out-File -FilePath $configFile -Encoding UTF8
    
    Write-ColoredOutput "Green" "✅ 配置已生成：$configFile"
}

# 显示 MCP 服务器信息
function Show-McpInfo {
    Write-Host ""
    Write-ColoredOutput "Blue" "=== MCP 服务器设置信息 ==="
    Write-Host ""
    Write-ColoredOutput "Green" "✅ MCP 服务器已配置到 settings.local.json 中！"
    Write-Host ""
    Write-Host "配置的服务器："
    
    Write-ColoredOutput "Yellow" "📚 Context7 MCP 服务器："
    Write-Host "  • 提供最新外部库文档"
    Write-Host "  • 支持 React、FastAPI、Next.js 等"
    Write-Host "  • 使用方法：mcp__context7__get_library_docs"
    Write-Host ""
    
    Write-ColoredOutput "Yellow" "🧠 Gemini MCP 服务器："
    Write-Host "  • 深度架构咨询"
    Write-Host "  • 高级代码审查"
    Write-Host "  • 使用方法：mcp__gemini__consult_gemini"
    Write-Host ""
    
    Write-ColoredOutput "Cyan" "💡 重要配置提醒："
    Write-Host "  • Context7 需要 API 密钥，编辑 .claude/settings.local.json"
    Write-Host "    替换 YOUR_CONTEXT7_API_KEY 为你的真实 API 密钥"
    Write-Host "  • Gemini MCP 不需要 API 密钥，直接使用"
}

# 主安装流程
function Main {
    Show-Header
    Write-ColoredOutput "Cyan" "🎯 目标目录: $TargetDir"
    
    # 检查目录权限
    try {
        $testFile = Join-Path $TargetDir "test_write_$(Get-Date -Format 'yyyyMMddHHmmss')"
        New-Item -ItemType File -Path $testFile -Force | Out-Null
        Remove-Item -Path $testFile -Force
    } catch {
        Write-ColoredOutput "Red" "❌ 无法写入目标目录: $TargetDir"
        exit 1
    }
    
    # 询问可选组件
    Prompt-OptionalComponents
    
    Write-Host ""
    Write-ColoredOutput "Yellow" "📄 正在复制中文化模板文件..."
    
    # 复制 CLAUDE.md
    $claudeMdSource = "templates/CLAUDE.md"
    $claudeMdTarget = Join-Path $TargetDir "CLAUDE.md"
    if (Test-Path $claudeMdSource) {
        try {
            Copy-Item $claudeMdSource $claudeMdTarget -Force -ErrorAction Stop
            Write-ColoredOutput "Green" "  ✅ CLAUDE.md (主 AI 上下文文件)"
        } catch {
            Write-ColoredOutput "Yellow" "  ⚠️  CLAUDE.md 已存在，跳过复制"
        }
    }
    
    # 复制 MCP 规则
    $mcpRulesSource = "templates/MCP-ASSISTANT-RULES.md"
    $mcpRulesTarget = Join-Path $TargetDir "MCP-ASSISTANT-RULES.md"
    if (Test-Path $mcpRulesSource) {
        try {
            Copy-Item $mcpRulesSource $mcpRulesTarget -Force -ErrorAction Stop
            Write-ColoredOutput "Green" "  ✅ MCP-ASSISTANT-RULES.md (MCP 助手规则)"
        } catch {
            Write-ColoredOutput "Yellow" "  ⚠️  MCP-ASSISTANT-RULES.md 已存在，跳过复制"
        }
    }
    
    # 复制文档文件
    $docsSource = "templates/docs"
    if (Test-Path $docsSource) {
        $docsTarget = Join-Path $TargetDir "docs"
        if (!(Test-Path $docsTarget)) {
            New-Item -ItemType Directory -Path $docsTarget -Force | Out-Null
        }
        
        $aiContextTarget = Join-Path $docsTarget "ai-context"
        if (!(Test-Path $aiContextTarget)) {
            New-Item -ItemType Directory -Path $aiContextTarget -Force | Out-Null
        }
        
        Get-ChildItem -Path $docsSource -Recurse -Filter "*.md" | ForEach-Object {
            $relativePath = $_.FullName.Substring($docsSource.Length + 1)
            $targetFile = Join-Path $docsTarget $relativePath
            $targetDir = Split-Path $targetFile -Parent
            
            if (!(Test-Path $targetDir)) {
                New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
            }
            
            if (!(Test-Path $targetFile)) {
                Copy-Item $_.FullName $targetFile -Force
            }
        }
        Write-ColoredOutput "Green" "  ✅ docs/ (中文文档系统)"
    }
    
    # 复制 .claude 目录
    $claudeSource = "templates/.claude"
    if (Test-Path $claudeSource) {
        $claudeTarget = Join-Path $TargetDir ".claude"
        if (!(Test-Path $claudeTarget)) {
            New-Item -ItemType Directory -Path $claudeTarget -Force | Out-Null
        }
        
        # 复制 commands
        $commandsSource = Join-Path $claudeSource "commands"
        if (Test-Path $commandsSource) {
            $commandsTarget = Join-Path $claudeTarget "commands"
            if (!(Test-Path $commandsTarget)) {
                New-Item -ItemType Directory -Path $commandsTarget -Force | Out-Null
            }
            Copy-Item "$commandsSource/*" $commandsTarget -Recurse -Force -ErrorAction SilentlyContinue
            Write-ColoredOutput "Green" "  ✅ .claude/commands/ (Claude Code 命令集)"
        }
        
        # 复制 hooks
        $hooksSource = Join-Path $claudeSource "hooks"
        if (Test-Path $hooksSource) {
            $hooksTarget = Join-Path $claudeTarget "hooks"
            if (!(Test-Path $hooksTarget)) {
                New-Item -ItemType Directory -Path $hooksTarget -Force | Out-Null
            }
            Copy-Item "$hooksSource/*" $hooksTarget -Recurse -Force -ErrorAction SilentlyContinue
            Write-ColoredOutput "Green" "  ✅ .claude/hooks/ (中文化 Hook 脚本和配置)"
        }
    }
    
    # 复制示例
    $examplesSource = "examples"
    if (Test-Path $examplesSource) {
        $examplesTarget = Join-Path $TargetDir "examples"
        if (!(Test-Path $examplesTarget)) {
            New-Item -ItemType Directory -Path $examplesTarget -Force | Out-Null
        }
        Copy-Item "$examplesSource/*" $examplesTarget -Recurse -Force -ErrorAction SilentlyContinue
        Write-ColoredOutput "Green" "  ✅ examples/ (中文使用示例)"
    }
    
    Write-Host ""
    Write-ColoredOutput "Cyan" "🔧 正在生成项目配置..."
    
    # 生成配置文件
    Generate-Settings
    
    # 显示 MCP 信息
    Show-McpInfo
    
    Write-Host ""
    Write-ColoredOutput "Green" "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    Write-ColoredOutput "Green" "🎉 Claude Code 中文开发套件设置完成！"
    Write-ColoredOutput "Green" "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    Write-Host ""
    Write-ColoredOutput "Cyan" "📖 下一步："
    Write-Host "  1. 查看 CLAUDE.md 了解中文化的 AI 指令"
    Write-Host "  2. 阅读 docs/README.md 学习文档系统"
    Write-Host "  3. 参考 examples/ 目录中的使用示例"
    Write-Host "  4. 运行 'claude' 开始你的中文开发之旅！"
    
    # MCP 服务器安装指导
    Write-Host ""
    Write-ColoredOutput "Cyan" "📡 推荐安装 MCP 服务器增强功能："
    Write-Host ""
    Write-ColoredOutput "Yellow" "Context7 - 获取最新库文档："
    Write-Host "  claude mcp add context7 --scope project -- npx -y @upstash/context7-mcp --api-key YOUR_CONTEXT7_API_KEY"
    Write-Host ""
    Write-ColoredOutput "Yellow" "Gemini - 深度代码分析和咨询："
    Write-Host "  claude mcp add gemini --scope project -- npx -y gemini-mcp-tool"
    Write-Host ""
    Write-ColoredOutput "Yellow" "💡 MCP 服务器让 Claude Code 功能更强大，强烈推荐安装！"
}

# 运行主函数
Main @args