rm -rf .import
find . -type f -name "*.import" -delete
git add -A
git commit
git pull git@gitee.com:t1c/The_Due_of_Eras.git
git pull git@github.com:shiyou-t1c/The_Due_of_Eras.git
git push git@gitee.com:t1c/The_Due_of_Eras.git
git push git@github.com:shiyou-t1c/The_Due_of_Eras.git
