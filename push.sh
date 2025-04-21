git pull git@gitee.com:t1c/The_Due_of_Eras.git
git pull git@github.com:shiyou-t1c/The_Due_of_Eras.git
git pull ssh://t1c@git.code.sf.net/p/the-due-of-eras/code

rm -rf .import
find . -type f -name "*.import" -delete

git add -A
git commit

git push git@gitee.com:t1c/The_Due_of_Eras.git
git push git@github.com:shiyou-t1c/The_Due_of_Eras.git
git push ssh://t1c@git.code.sf.net/p/the-due-of-eras/code
