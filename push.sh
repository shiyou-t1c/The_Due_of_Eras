#!/bin/bash

# SPDX-FileCopyrightText: 2025 all contributors
# SPDX-FileCopyrightText: 2025 shiyou(t1c)
#
# SPDX-License-Identifier: MIT

set -e  # 任何命令失败则退出脚本

rm -rf .import
rm -rf default_env.tres.tmp
find . -type f -name "*.import" -delete

# 配置远程仓库地址
remote_repos=(
    "git@gitee.com:t1c/The_Due_of_Eras.git"
    "git@github.com:shiyou-t1c/The_Due_of_Eras.git"
    "ssh://t1c@git.code.sf.net/p/the-due-of-eras/code"
)

# 遍历所有远程仓库
for repo_url in "${remote_repos[@]}"; do
    echo "正在处理仓库: $repo_url"

    # 获取远程仓库所有分支名称（排除HEAD指针）
    remote_branches=$(git ls-remote --heads "$repo_url" | grep -E "refs/heads/" | sed 's%.*refs/heads/%%')

    # 检查分支列表是否为空
    if [ -z "$remote_branches" ]; then
        echo "警告：仓库 $repo_url 无有效分支，跳过处理。"
        continue
    fi

    # 遍历分支并拉取
    for branch in $remote_branches; do
        echo "  → 拉取分支: $branch"

        # 本地分支存在时直接拉取，否则创建并跟踪
        if git show-ref --quiet --verify "refs/heads/${branch}"; then
            git pull "$repo_url" "$branch"
        else
            git fetch "$repo_url" "$branch:$branch"
            git checkout -q "$branch"
        fi
    done
done

echo "所有仓库分支已同步完成！"

rm -rf .import
find . -type f -name "*.import" -delete
rm -rf default_env.tres.tmp

# 提交master分支
git checkout master
git add -A
if ! git commit -m "提交更改到master分支"; then
    echo "master分支无更改可提交"
fi

# 合并master到其他分支
for branch in $(git branch --list | grep -v ' master$' | sed 's/^* //'); do
    echo "合并master到分支 $branch"
    git checkout "$branch"
    git merge master --no-ff -m "合并master分支到$branch"
    git add -A
    if ! git commit -m "合并后的提交"; then
        echo "无更改需要提交"
    fi
done

# 推送所有分支到各个远程仓库
for repo_url in "${remote_repos[@]}"; do
    echo "正在推送分支到远程仓库: $repo_url"
    for branch in $(git branch --list | sed 's/^* //'); do
        echo "推送分支 $branch"
        git push "$repo_url" "$branch:$branch"
    done
done

git checkout master
git branch
