#!/bin/bash

# 过滤内部状态追踪和监控内容的脚本（最终版）
# 只保留有效的脚本版本

INPUT_DIR="/root/.openclaw/workspace/novel_project/chapters"
OUTPUT_DIR="/root/.openclaw/workspace/novel_project/formal"

# 创建输出目录
mkdir -p "$OUTPUT_DIR"

# 处理每个章节
for file in "$INPUT_DIR"/chapter_0[1-9].md "$INPUT_DIR"/chapter_10.md; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        
        # 复制原始文件到输出目录
        cp "$file" "$OUTPUT_DIR/$filename"
        
        # 过滤内部状态追踪和监控内容
        # 使用简单的字符串替换，删除内部标记
        sed -i '/<!-- INTERNAL -->/,/<!-- \/INTERNAL -->/d' "$OUTPUT_DIR/$filename"
        
        # 过滤非正文内容
        sed -i '/【第[0-9]章开始状态】/,/---/d' "$OUTPUT_DIR/$filename"
        sed -i '/【状态更新[0-9]】/,/---/d' "$OUTPUT_DIR/$filename"
        sed -i '/【第[0-9]章结束状态】/,/---/d' "$OUTPUT_DIR/$filename"
        sed -i '/【下一章承接提示】/,/---/d' "$OUTPUT_DIR/$filename"
        
        # 删除多余的空行
        sed -i '/^$/N;/^\n$/D' "$OUTPUT_DIR/$filename"
        
        echo "处理完成：$filename"
    fi
done

echo "所有章节已处理完成！"
echo "正式小说文件已保存到：$OUTPUT_DIR"
