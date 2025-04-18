rm -rf .import
find . -type f -name "*.import" -delete
git add -A
git commit
git push https://gitee.com/t1c/The_Due_of_Eras.git
