#!/usr/bin/env python3
"""
Claude Code 指南中文翻译处理脚本
使用方法：python3 translate_claude_guide.py <original_markdown_file>
"""

import re
import os
import sys
import json
from pathlib import Path

class ClaudeGuideTranslator:
    def __init__(self, original_file):
        self.original_file = original_file
        self.content = ""
        self.structure = []
        self.terminology = {}
        
        # 技术术语对照表
        self.tech_terms = {
            "Claude Code": "Claude Code",
            "CLI": "命令行界面",
            "API": "API",
            "JSON": "JSON",
            "Markdown": "Markdown",
            "GitHub": "GitHub",
            "repository": "仓库",
            "branch": "分支",
            "commit": "提交",
            "pull request": "拉取请求",
            "configuration": "配置",
            "installation": "安装",
            "deployment": "部署",
            "debugging": "调试",
            "testing": "测试",
            "integration": "集成",
            "automation": "自动化",
            "workflow": "工作流程",
            "plugin": "插件",
            "extension": "扩展",
            "template": "模板",
            "context": "上下文",
            "environment": "环境",
            "variable": "变量",
            "function": "函数",
            "method": "方法",
            "class": "类",
            "object": "对象",
            "module": "模块",
            "package": "包",
            "dependency": "依赖",
            "framework": "框架",
            "library": "库",
            "database": "数据库",
            "server": "服务器",
            "client": "客户端",
            "authentication": "认证",
            "authorization": "授权",
            "encryption": "加密",
            "security": "安全",
            "performance": "性能",
            "optimization": "优化",
            "scalability": "可扩展性",
            "maintainability": "可维护性",
            "documentation": "文档",
            "tutorial": "教程",
            "guide": "指南",
            "reference": "参考",
            "example": "示例",
            "sample": "示例",
            "demonstration": "演示",
            "walkthrough": " walkthrough",
            "overview": "概述",
            "introduction": "介绍",
            "getting started": "快速开始",
            "prerequisites": "先决条件",
            "requirements": "要求",
            "setup": "设置",
            "configuration": "配置",
            "troubleshooting": "故障排除",
            "FAQ": "常见问题",
            "best practices": "最佳实践",
            "tips": "技巧",
            "tricks": "技巧",
            "hacks": "技巧",
            "secrets": "秘诀",
            "advanced": "高级",
            "intermediate": "中级",
            "beginner": "初学者",
            "expert": "专家",
            "professional": "专业",
            "enterprise": "企业",
            "community": "社区",
            "contribution": "贡献",
            "open source": "开源",
            "license": "许可证",
            "copyright": "版权",
            "trademark": "商标",
            "patent": "专利",
            "intellectual property": "知识产权"
        }
    
    def load_content(self):
        """加载原始内容"""
        try:
            with open(self.original_file, 'r', encoding='utf-8') as f:
                self.content = f.read()
            print(f"成功加载内容：{len(self.content)} 字符")
            return True
        except Exception as e:
            print(f"加载文件失败：{e}")
            return False
    
    def analyze_structure(self):
        """分析文档结构"""
        lines = self.content.split('\n')
        headers = []
        
        for line_num, line in enumerate(lines, 1):
            if line.startswith('#'):
                level = len(line) - len(line.lstrip('#'))
                title = line.lstrip('#').strip()
                headers.append({
                    'level': level,
                    'title': title,
                    'line_num': line_num,
                    'content': []
                })
        
        self.structure = headers
        print(f"发现 {len(headers)} 个标题")
        
        # 显示结构
        for header in headers:
            indent = "  " * (header['level'] - 1)
            print(f"{indent}H{header['level']}: {header['title']}")
        
        return headers
    
    def extract_section_content(self, headers):
        """提取各章节内容"""
        lines = self.content.split('\n')
        
        for i, header in enumerate(headers):
            start_line = header['line_num']
            
            # 找到下一个同级或更高级标题的位置
            end_line = len(lines)
            for j in range(i + 1, len(headers)):
                if headers[j]['level'] <= header['level']:
                    end_line = headers[j]['line_num'] - 1
                    break
            
            # 提取内容
            section_lines = lines[start_line:end_line]
            header['content'] = '\n'.join(section_lines)
        
        return headers
    
    def translate_text(self, text, preserve_code=True):
        """翻译文本内容"""
        # 保留代码块
        if preserve_code:
            code_blocks = re.findall(r'```.*?```', text, re.DOTALL)
            inline_code = re.findall(r'`[^`\n]+`', text)
            
            # 临时替换代码块
            placeholders = {}
            for i, block in enumerate(code_blocks):
                placeholder = f"__CODE_BLOCK_{i}__"
                placeholders[placeholder] = block
                text = text.replace(block, placeholder)
            
            for i, code in enumerate(inline_code):
                placeholder = f"__INLINE_CODE_{i}__"
                placeholders[placeholder] = code
                text = text.replace(code, placeholder)
        
        # 替换技术术语
        for en_term, cn_term in self.tech_terms.items():
            # 使用单词边界确保完整匹配
            pattern = r'\b' + re.escape(en_term) + r'\b'
            text = re.sub(pattern, cn_term, text, flags=re.IGNORECASE)
        
        # 恢复代码块
        if preserve_code:
            for placeholder, original in placeholders.items():
                text = text.replace(placeholder, original)
        
        return text
    
    def generate_chinese_structure(self, headers):
        """生成中文文档结构"""
        chinese_structure = []
        
        for header in headers:
            level = header['level']
            title = header['title']
            
            # 转换为中文标题
            cn_title = self.translate_title(title, level)
            
            chinese_structure.append({
                'level': level,
                'original_title': title,
                'chinese_title': cn_title,
                'filename': self.generate_filename(cn_title, level)
            })
        
        return chinese_structure
    
    def translate_title(self, title, level):
        """翻译标题"""
        # 常见标题映射
        title_mappings = {
            "Introduction": "介绍",
            "Getting Started": "快速开始",
            "Installation": "安装",
            "Configuration": "配置",
            "Basic Usage": "基本使用",
            "Advanced Features": "高级功能",
            "Examples": "示例",
            "Troubleshooting": "故障排除",
            "API Reference": "API参考",
            "Contributing": "贡献指南",
            "License": "许可证",
            "Overview": "概述",
            "Prerequisites": "先决条件",
            "Requirements": "系统要求",
            "Setup": "设置",
            "Configuration": "配置",
            "Best Practices": "最佳实践",
            "Tips and Tricks": "技巧和秘诀",
            "Common Issues": "常见问题",
            "Debugging": "调试",
            "Testing": "测试",
            "Deployment": "部署",
            "Security": "安全",
            "Performance": "性能",
            "Optimization": "优化",
            "Integration": "集成",
            "Automation": "自动化",
            "Workflow": "工作流程",
            "Plugins": "插件",
            "Extensions": "扩展",
            "Templates": "模板",
            "Context": "上下文",
            "Environment": "环境",
            "Variables": "变量",
            "Functions": "函数",
            "Methods": "方法",
            "Classes": "类",
            "Objects": "对象",
            "Modules": "模块",
            "Packages": "包",
            "Dependencies": "依赖",
            "Frameworks": "框架",
            "Libraries": "库",
            "Databases": "数据库",
            "Servers": "服务器",
            "Clients": "客户端",
            "Authentication": "认证",
            "Authorization": "授权",
            "Encryption": "加密",
            "Community": "社区",
            "Contributions": "贡献",
            "Open Source": "开源",
            "Resources": "资源",
            "Documentation": "文档",
            "Tutorials": "教程",
            "Guides": "指南",
            "References": "参考",
            "Examples": "示例",
            "Samples": "示例",
            "Demonstrations": "演示",
            "Walkthroughs": "详细指南",
            "FAQ": "常见问题",
            "Glossary": "术语表",
            "Index": "索引",
            "Appendix": "附录"
        }
        
        # 查找映射
        for en_title, cn_title in title_mappings.items():
            if en_title.lower() in title.lower():
                return title.replace(en_title, cn_title, 1)
        
        # 如果没有找到映射，尝试翻译
        return self.translate_text(title, preserve_code=False)
    
    def generate_filename(self, title, level):
        """生成文件名"""
        # 移除特殊字符，转换为小写，用连字符连接
        import re
        filename = re.sub(r'[^\w\s-]', '', title.lower())
        filename = re.sub(r'[-\s]+', '-', filename)
        filename = filename.strip('-')
        
        # 添加章节前缀
        if level == 1:
            return f"chapter-{filename}.md"
        elif level == 2:
            return f"section-{filename}.md"
        else:
            return f"subsection-{filename}.md"
    
    def create_directory_structure(self, base_path):
        """创建目录结构"""
        base_dir = Path(base_path)
        
        # 创建主目录
        (base_dir / "claude-code-guide-zh").mkdir(parents=True, exist_ok=True)
        
        # 创建章节目录
        chapter_dirs = [
            "01-introduction",
            "02-core-features", 
            "03-advanced-features",
            "04-best-practices",
            "05-practical-examples",
            "06-reference"
        ]
        
        for dir_name in chapter_dirs:
            (base_dir / "claude-code-guide-zh" / dir_name).mkdir(exist_ok=True)
        
        print(f"创建目录结构：{base_dir}/claude-code-guide-zh/")
    
    def process_document(self):
        """处理整个文档"""
        print("开始处理 Claude Code 指南...")
        
        # 1. 加载内容
        if not self.load_content():
            return False
        
        # 2. 分析结构
        headers = self.analyze_structure()
        
        # 3. 提取章节内容
        headers_with_content = self.extract_section_content(headers)
        
        # 4. 生成中文结构
        chinese_structure = self.generate_chinese_structure(headers_with_content)
        
        # 5. 创建目录结构
        self.create_directory_structure("/home/runner/work/claude-init/claude-init/docs")
        
        # 6. 保存分析结果
        analysis_result = {
            'original_file': self.original_file,
            'total_headers': len(headers),
            'structure': headers_with_content,
            'chinese_structure': chinese_structure,
            'terminology': self.tech_terms
        }
        
        with open('/home/runner/work/claude-init/claude-init/docs/claude-guide-analysis.json', 'w', encoding='utf-8') as f:
            json.dump(analysis_result, f, ensure_ascii=False, indent=2)
        
        print("处理完成！分析结果已保存。")
        return True

def main():
    if len(sys.argv) != 2:
        print("使用方法：python3 translate_claude_guide.py <原始markdown文件>")
        sys.exit(1)
    
    original_file = sys.argv[1]
    
    if not os.path.exists(original_file):
        print(f"文件不存在：{original_file}")
        sys.exit(1)
    
    translator = ClaudeGuideTranslator(original_file)
    translator.process_document()

if __name__ == "__main__":
    main()