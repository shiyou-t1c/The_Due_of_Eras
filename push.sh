git pull --all git@gitee.com:t1c/The_Due_of_Eras.git
git pull --all git@github.com:shiyou-t1c/The_Due_of_Eras.git
git pull --all ssh://t1c@git.code.sf.net/p/the-due-of-eras/code

rm -rf .import
find . -type f -name "*.import" -delete

git add -A
git commit

git push --all git@gitee.com:t1c/The_Due_of_Eras.git
git push --all git@github.com:shiyou-t1c/The_Due_of_Eras.git
git push --all ssh://t1c@git.code.sf.net/p/the-due-of-eras/code
