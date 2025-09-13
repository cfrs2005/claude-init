#!/usr/bin/env pwsh

# Claude Code 中文开发套件远程安装器 (PowerShell 版本)
#
# 该脚本下载并安装 Claude Code 中文开发套件
# 使用方法: irm https://raw.githubusercontent.com/cfrs2005/claude-init/main/install.ps1 | iex

[CmdletBinding()]
param()

# 配置
$RepoOwner = "cfrs2005"
$RepoName = "claude-init"
$Branch = "main"

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

# 进度指示器
function Show-Spinner {
    param(
        [int]$ProcessId
    )
    
    $spinnerChars = @('⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏')
    $index = 0
    
    while (!(Get-Process -Id $ProcessId -ErrorAction SilentlyContinue).HasExited) {
        Write-Host " [$($spinnerChars[$index])]  " -NoNewline
        $index = ($index + 1) % $spinnerChars.Length
        Start-Sleep -Milliseconds 100
        Write-Host "`b$b$b$b$b$b" -NoNewline
    }
    Write-Host "    `b$b$b$b" -NoNewline
}

# 错误处理
$ErrorActionPreference = "Stop"

# 清理临时文件
$TempDir = $null
function Cleanup {
    if ($TempDir -and (Test-Path $TempDir)) {
        Write-ColoredOutput "Yellow" "🧹 正在清理临时文件..."
        Remove-Item -Path $TempDir -Recurse -Force
        Write-ColoredOutput "Green" "✅ 清理完成"
    }
}

# 注册清理
Register-EngineEvent PowerShell.Exiting -Action { Cleanup }

# 打印横幅
Clear-Host
Write-ColoredOutput "Blue" "╔═══════════════════════════════════════════════╗"
Write-ColoredOutput "Blue" "║                                               ║"
Write-ColoredOutput "Blue" "║    🚀 Claude Code 中文开发套件安装器         ║"
Write-ColoredOutput "Blue" "║                                               ║"
Write-ColoredOutput "Blue" "╚═══════════════════════════════════════════════╝"
Write-Host ""

# 检查 PowerShell 版本
Write-ColoredOutput "Yellow" "📋 正在检查系统要求..."
if ($PSVersionTable.PSVersion.Major -lt 5) {
    Write-ColoredOutput "Red" "❌ 需要 PowerShell 5.1 或更高版本"
    Write-ColoredOutput "Yellow" "当前版本: $($PSVersionTable.PSVersion)"
    exit 1
}

# 检查必要命令
$missingDeps = @()
$requiredCommands = @("curl", "tar")

foreach ($cmd in $requiredCommands) {
    try {
        Get-Command $cmd -ErrorAction Stop | Out-Null
    } catch {
        $missingDeps += $cmd
    }
}

if ($missingDeps.Count -gt 0) {
    # Windows 上可能没有 curl/tar，使用 PowerShell 内置功能
    Write-ColoredOutput "Yellow" "⚠️  部分命令缺失: $($missingDeps -join ', ')"
    Write-ColoredOutput "Yellow" "将使用 PowerShell 内置功能替代"
}

Write-ColoredOutput "Green" "✅ 系统要求已满足"
Write-Host ""

# 创建临时目录
$TempDir = [System.IO.Path]::GetTempPath() + "claude-init-" + [Guid]::NewGuid().ToString()
New-Item -ItemType Directory -Path $TempDir -Force | Out-Null

# 下载框架
Write-ColoredOutput "Cyan" "📥 正在下载 Claude Code 中文开发套件..."
$DownloadUrl = "https://api.github.com/repos/$RepoOwner/$RepoName/tarball/$Branch"
$TarballPath = Join-Path $TempDir "framework.tar.gz"

try {
    # 使用 Invoke-WebRequest 下载
    $webClient = New-Object System.Net.WebClient
    $webClient.DownloadFile($DownloadUrl, $TarballPath)
    
    $fileInfo = Get-Item $TarballPath
    Write-ColoredOutput "Green" "✅ 下载完成 ($([math]::Round($fileInfo.Length / 1KB, 2))KB)"
} catch {
    Write-ColoredOutput "Red" "❌ 下载框架失败"
    Write-ColoredOutput "Red" "错误: $($_.Exception.Message)"
    Write-Host ""
    Write-ColoredOutput "Yellow" "可能的解决方案："
    Write-Host "  1. 检查你的网络连接"
    Write-Host "  2. 验证仓库是否存在: https://github.com/$RepoOwner/$RepoName"
    Write-Host "  3. 确保 Claude Code 已安装: https://github.com/anthropics/claude-code"
    Write-Host "  4. 尝试手动安装 (git clone)"
    exit 1
}

# 解压文件
Write-Host ""
Write-ColoredOutput "Cyan" "📦 正在解压框架文件..."

try {
    # 使用 .NET 的解压功能
    Add-Type -AssemblyName "System.IO.Compression.FileSystem"
    Add-Type -AssemblyName "System.IO.Compression.ZipFile"
    
    # 重命名为 .zip 才能解压
    $zipPath = Join-Path $TempDir "framework.zip"
    Copy-Item $TarballPath $zipPath -Force
    
    # 解压到临时目录
    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipPath, $TempDir)
    
    # 查找解压目录
    $extractDirs = Get-ChildItem -Path $TempDir -Directory | Where-Object { $_.Name -like "$RepoOwner-$RepoName-*" }
    if ($extractDirs.Count -eq 0) {
        throw "找不到解压的框架目录"
    }
    
    $ExtractDir = $extractDirs[0].FullName
    Write-ColoredOutput "Green" "✅ 解压完成"
} catch {
    Write-ColoredOutput "Red" "❌ 解压框架失败"
    Write-ColoredOutput "Red" "错误: $($_.Exception.Message)"
    exit 1
}

Write-Host ""

# 验证 setup.ps1 存在
$SetupScript = Join-Path $ExtractDir "setup.ps1"
if (!(Test-Path $SetupScript)) {
    Write-ColoredOutput "Red" "❌ 在解压文件中未找到 setup.ps1"
    exit 1
}

# 保存当前目录
$OriginalPwd = Get-Location

# 切换到解压目录并运行设置
Set-Location $ExtractDir

Write-ColoredOutput "Cyan" "🔧 开始框架设置..."
Write-ColoredOutput "Cyan" "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
Write-Host ""

try {
    # 运行实际的设置脚本
    $env:INSTALLER_ORIGINAL_PWD = $OriginalPwd.Path
    & powershell.exe -ExecutionPolicy Bypass -File $SetupScript @args
    
    if ($LASTEXITCODE -ne 0) {
        throw "设置脚本执行失败"
    }
} catch {
    Write-Host ""
    Write-ColoredOutput "Red" "❌ 设置失败"
    Write-ColoredOutput "Yellow" "你可以尝试手动安装："
    Write-Host "  git clone https://github.com/$RepoOwner/$RepoName.git"
    Write-Host "  cd $RepoName"
    Write-Host "  ./setup.ps1"
    exit 1
}

# 成功！
Write-Host ""
Write-ColoredOutput "Green" "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
Write-ColoredOutput "Green" "🎉 Claude Code 中文开发套件安装完成！"
Write-ColoredOutput "Green" "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"