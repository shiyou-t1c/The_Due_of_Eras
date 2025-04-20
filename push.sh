rm -rf .import
find . -type f -name "*.import" -delete
git add -A
git commit
git push https://gitee.com/t1c/The_Due_of_Eras.git
git push https://github.com/shiyou-t1c/The_Due_of_Eras
git push https://t1c@git.code.sf.net/p/the-due-of-eras/code the-due-of-eras-code
