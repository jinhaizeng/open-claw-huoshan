#!/bin/bash

# 过滤所有章节内部状态追踪和监控内容的脚本（最终版）

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
        sed -i '/质量监控体系验证结果/,/验证结论/d' "$OUTPUT_DIR/$filename"
        sed -i '/严格按质量监控系统执行，验证体系有效性/d' "$OUTPUT_DIR/$filename"
        sed -i '/新手大礼包免费使用/d' "$OUTPUT_DIR/$filename"
        sed -i '/## 第一节.*\|## 第二节.*\|## 第三节.*\|## 第四节.*\|## 第五节.*/d' "$OUTPUT_DIR/$filename"
        sed -i '/> 第[0-9]天完成.*/d' "$OUTPUT_DIR/$filename"
        
        # 再次过滤可能漏过的非正文内容
        sed -i '/【第[0-9]章开始状态】/d' "$OUTPUT_DIR/$filename"
        sed -i '/【状态更新[0-9]】/d' "$OUTPUT_DIR/$filename"
        sed -i '/【第[0-9]章结束状态】/d' "$OUTPUT_DIR/$filename"
        sed -i '/【下一章承接提示】/d' "$OUTPUT_DIR/$filename"
        sed -i '/质量监控体系验证结果/d' "$OUTPUT_DIR/$filename"
        sed -i '/严格按质量监控系统执行，验证体系有效性/d' "$OUTPUT_DIR/$filename"
        sed -i '/新手大礼包免费使用/d' "$OUTPUT_DIR/$filename"
        sed -i '/## 第一节.*\|## 第二节.*\|## 第三节.*\|## 第四节.*\|## 第五节.*/d' "$OUTPUT_DIR/$filename"
        sed -i '/> 第[0-9]天完成.*/d' "$OUTPUT_DIR/$filename"
        
        # 直接删除最后一个【---】
        sed -i '/---$/d' "$OUTPUT_DIR/$filename"
        
        # 删除多余的空行
        sed -i '/^$/N;/^\n$/D' "$OUTPUT_DIR/$filename"
        
        echo "处理完成：$filename"
    fi
done

echo "所有章节已处理完成！"
echo "正式小说文件已保存到：$OUTPUT_DIR"
