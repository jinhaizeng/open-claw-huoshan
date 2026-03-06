#!/bin/bash

# 清理小说草稿标记，生成最终正文的脚本
# 特殊标记格式：[草稿开始] ... [草稿结束]

INPUT_DIR="/root/.openclaw/workspace/novel_project/chapters"
OUTPUT_DIR="/root/.openclaw/workspace/novel_project/formal"

# 创建输出目录
mkdir -p "$OUTPUT_DIR"

# 处理每个章节
for file in "$INPUT_DIR"/chapter_0[1-9]_final.md "$INPUT_DIR"/chapter_10_final.md; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        
        # 复制原始文件到输出目录
        cp "$file" "$OUTPUT_DIR/$filename"
        
        # 清理特殊标记
        # [草稿开始] ... [草稿结束] 整个块
        sed -i '/\[草稿开始\]/,/\[草稿结束\]/d' "$OUTPUT_DIR/$filename"
        
        # 清理状态追踪表相关内容
        sed -i '/## 📊 状态追踪表/,/---/d' "$OUTPUT_DIR/$filename"
        sed -i '/## 📖 词条说明/,/---/d' "$OUTPUT_DIR/$filename"
        sed -i '/## 📋 下一章预告/,/---/d' "$OUTPUT_DIR/$filename"
        sed -i '/## 📋 敌人情报/,/---/d' "$OUTPUT_DIR/$filename"
        
        # 清理其他非正文内容
        sed -i '/## ✅ .*完成.*/d' "$OUTPUT_DIR/$filename"
        sed -i '/## ⚠️ .*/d' "$OUTPUT_DIR/$filename"
        
        # 清理TODO标记
        sed -i '/\[TODO:.*\]/d' "$OUTPUT_DIR/$filename"
        
        # 删除最后一个 ---
        sed -i '/^---$/d' "$OUTPUT_DIR/$filename"
        
        # 删除多余的空行（最多连续3个空行变成1个）
        sed -i '/^$/N;/^\n$/N;/^\n$/d' "$OUTPUT_DIR/$filename"
        
        echo "处理完成：$filename"
    fi
done

echo "所有章节已处理完成！"
echo "正式小说文件已保存到：$OUTPUT_DIR"