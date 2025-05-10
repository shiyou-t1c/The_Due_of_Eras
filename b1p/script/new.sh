#!/bin/bash

# SPDX-FileCopyrightText: 2025 shiyou(t1c) and all contributors
#
# SPDX-License-Identifier: MIT

# 用户输入前缀（如 b1_1_1）
read -p "请输入前缀（示例：b1_1）: " full_prefix
export full_prefix  # 确保子进程继承变量

# 预定义许可证文件内容模板
LICENSE_CONTENT="SPDX-FileCopyrightText: 2025 shiyou(t1c) and all contributors\n\nSPDX-License-Identifier: MIT"

# 并发控制参数
MAX_JOBS=4        # 最大并发进程数
current_jobs=0    # 当前运行进程计数器

# 创建临时日志目录
LOG_DIR=$(mktemp -d)
trap 'rm -rf "$LOG_DIR"' EXIT  # 脚本退出时清理日志

# 并发处理函数
process_dir() {
    local dir="$1"
    local dirname=$(basename "$dir")
    local log_file="${LOG_DIR}/${dirname}.log"

    # 初始化日志文件
    echo "▸ 扫描目录: $dirname" > "$log_file"

    # 构建文件路径
    local tres_file="${dir}/${full_prefix}${dirname}.tres"
    local license_file="${tres_file}.license"

    # 创建文件并处理许可证内容
    for file in "$tres_file" "$license_file"; do
        if [[ ! -e "$file" ]]; then
            touch "$file"
            echo "  创建: ${file##*/}" >> "$log_file"

            # 仅对新的空许可证文件填充内容
            if [[ "$file" == *.license && ! -s "$file" ]]; then
                echo -e "$LICENSE_CONTENT" > "$file"
                echo "  写入: 许可证模板 → ${file##*/}" >> "$log_file"
            fi
        elif [[ "$file" == *.license && ! -s "$file" ]]; then
            echo -e "$LICENSE_CONTENT" > "$file"
            echo "  更新: 空许可证文件 → ${file##*/}" >> "$log_file"
        else
            echo "  跳过: ${file##*/}（已存在且非空）" >> "$log_file"
        fi
    done
}

# 遍历一级子目录（增强路径兼容性）
while IFS= read -r -d $'\0' dir; do
    # 并发控制（当运行进程达上限时等待）
    if (( current_jobs >= MAX_JOBS )); then
        wait -n  # 等待任意一个子进程结束
        ((current_jobs--))
    fi

    # 启动后台任务
    ( process_dir "$dir" ) &
    ((current_jobs++))

done < <(find . -maxdepth 1 -type d ! -path . -print0)

# 等待剩余后台任务完成
wait

# 合并并输出所有日志（按目录名排序）
cat "${LOG_DIR}"/*.log
echo -e "\n✅ 文件生成完成（并发进程：${MAX_JOBS})"
