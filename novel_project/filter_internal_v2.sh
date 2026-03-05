#!/bin/bash

# 过滤内部状态追踪和监控内容的脚本（v2）
# 使用更精确的正则表达式，避免过度删除

INPUT_DIR="/root/.openclaw/workspace/novel_project/chapters"
OUTPUT_DIR="/root/.openclaw/workspace/novel_project/formal"

# 创建输出目录
mkdir -p "$OUTPUT_DIR"

# 处理每个章节
for file in "$INPUT_DIR"/chapter_0[1-9].md "$INPUT_DIR"/chapter_10.md; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        
        # 复制原始文件并保留备份
        cp "$file" "$OUTPUT_DIR/$filename"
        
        # 使用更精确的正则表达式匹配内部状态追踪和监控内容
        # 格式：<!-- INTERNAL --> 多行内容 <!-- /INTERNAL -->
        while grep -q '<!-- INTERNAL -->' "$OUTPUT_DIR/$filename"; do
            # 找到开始和结束标记的行号
            start=$(grep -n '<!-- INTERNAL -->' "$OUTPUT_DIR/$filename" | head -1 | cut -d: -f1)
            end=$(grep -n '<!-- \/INTERNAL -->' "$OUTPUT_DIR/$filename" | awk -v start="$start" '{if ($1 > start) print $1; exit}')
            
            # 删除开始到结束标记的所有内容
            if [ -n "$start" ] && [ -n "$end" ]; then
                sed -i.bak "${start},${end}d" "$OUTPUT_DIR/$filename"
                rm -f "$OUTPUT_DIR/$filename.bak"
            fi
        done
        
        echo "处理完成：$filename"
    fi
done

echo "所有章节已处理完成！"
echo "正式小说文件已保存到：$OUTPUT_DIR"
