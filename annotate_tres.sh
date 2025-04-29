#!/bin/bash

# SPDX-FileCopyrightText: 2025 shiyou(t1c) and all contributors
#
# SPDX-License-Identifier: MIT

# reuse annotate --copyright="shiyou(t1c) and all contributors" --license=MIT b1p/b1.tres --force-dot-license

# 配置参数
PROJECT_ROOT="$(pwd)"          # 项目根目录（按需修改）
COPYRIGHT_OWNER="shiyou(t1c) and all contributors"
LICENSE_TYPE="MIT"

# 查找并处理所有 .tres 文件
find "${PROJECT_ROOT}" -type f -name "*.tres" | while read -r file; do
    echo "▶ 正在处理文件: ${file}"
    reuse annotate \
        --copyright="${COPYRIGHT_OWNER}" \
        --license="${LICENSE_TYPE}" \
        "${file}" \
        --force-dot-license
done

echo "✅ 已完成所有 .tres 文件的许可证标注！"
