#!/bin/bash

# 过滤内部状态追踪和监控内容的脚本
# 使用特殊标记：<!-- INTERNAL --> 和 <!-- /INTERNAL -->

INPUT_DIR="/root/.openclaw/workspace/novel_project/chapters"
OUTPUT_DIR="/root/.openclaw/workspace/novel_project/formal"

# 创建输出目录
mkdir -p "$OUTPUT_DIR"

# 处理每个章节
for file in "$INPUT_DIR"/chapter_*.md; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        
        # 使用sed命令删除内部状态追踪和监控内容
        # 格式：<!-- INTERNAL --> 内容 <!-- /INTERNAL -->
        sed -i.bak ':a;N;$!ba;s/<!-- INTERNAL -->.*<!-- \/INTERNAL -->//g' "$file"
        
        # 删除备份文件
        rm -f "$file.bak"
        
        # 重新格式化章节标题（去除内部标记）
        sed -i 's/<!--.*-->//g' "$file"
        
        # 复制到正式小说目录
        cp "$file" "$OUTPUT_DIR/"
        
        echo "处理完成：$filename"
    fi
done

echo "所有章节已处理完成！"
echo "正式小说文件已保存到：$OUTPUT_DIR"
