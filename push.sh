#!/bin/bash
set -e  # 任何命令失败则退出脚本

rm -rf .import
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

git add -A
git commit

# 使用循环推送所有分支到各远程仓库
for repo_url in "${remote_repos[@]}"; do
    echo "正在推送更改到远程仓库: $repo_url"
    git push --all "$repo_url"
done
