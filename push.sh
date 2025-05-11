#!/bin/bash

# SPDX-FileCopyrightText: 2025 all contributors
# SPDX-FileCopyrightText: 2025 shiyou(t1c)
#
# SPDX-License-Identifier: MIT

set -e  # 任何命令失败则退出脚本

# 清理临时文件
cleanup() {
    rm -rf .import
    rm -rf default_env.tres.tmp
    find . -type f -name "*.import" -delete
}
cleanup

# 配置远程仓库地址
remote_repos=(
    "git@gitee.com:t1c/The_Due_of_Eras.git"
    "git@github.com:shiyou-t1c/The_Due_of_Eras.git"
    "ssh://t1c@git.code.sf.net/p/the-due-of-eras/code"
)

# 遍历所有远程仓库
for index in "${!remote_repos[@]}"; do
    repo_url="${remote_repos[$index]}"
    remote_name="temp_remote_${index}"
    echo "正在处理仓库: $repo_url"

    # 添加临时远程（忽略已存在的错误）
    git remote add "$remote_name" "$repo_url" 2>/dev/null || true

    # 获取远程分支列表（排除HEAD）
    git fetch "$remote_name"
    remote_branches=$(git ls-remote --heads "$remote_name" | grep -E "refs/heads/" | sed 's%.*refs/heads/%%')

    if [ -z "$remote_branches" ]; then
        echo "警告：仓库 $repo_url 无有效分支，跳过处理。"
        git remote remove "$remote_name" 2>/dev/null || true
        continue
    fi

    # 遍历分支并处理
    for branch in $remote_branches; do
        echo "  → 处理分支: $branch"

        # 检查本地分支是否存在
        if git show-ref --quiet --verify "refs/heads/${branch}"; then
            git checkout -q "$branch"
            git pull "$remote_name" "$branch"
        else
            # 创建并跟踪远程分支
            git checkout -b "$branch" --track "$remote_name/$branch"
        fi
    done

    # 移除临时远程
    git remote remove "$remote_name" 2>/dev/null || true
done

echo "所有仓库分支已同步完成！"

# 再次清理临时文件
cleanup

# 提交master分支
git checkout -q master
git add -A
if ! git commit -m "提交更改到master分支"; then
    echo "master分支无更改可提交"
fi

# 合并master到其他分支
for branch in $(git branch --list | grep -v ' master$' | sed 's/^* //'); do
    echo "合并master到分支 $branch"
    git checkout -q "$branch"
    if git merge master --no-ff -m "合并master分支到$branch"; then
        git add -A
        git commit --allow-empty -m "合并后的提交" || echo "无更改需要提交"
    else
        echo "合并冲突，请手动解决后继续"
        exit 1
    fi
done

# 并发推送所有分支到各个远程仓库
push_to_repo() {
    repo_url=$1
    echo "正在推送分支到远程仓库: $repo_url"
    for branch in $(git branch --list | sed 's/^* //'); do
        echo "推送分支 $branch 到 $repo_url"
        git push -q "$repo_url" "$branch:$branch"
    done
}
export -f push_to_repo

printf "%s\n" "${remote_repos[@]}" | xargs -P 3 -I {} bash -c 'push_to_repo "$@"' _ {}

# 最后切换回master分支
git checkout -q master
echo "操作完成，当前分支："
git branch
