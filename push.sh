# Due to the presence of a large number of binary files, when the repository size expands to a certain extent, first empty the repository directly on the web interface, and then use this script to resubmit.This operation was implemented by shiyou, the repository owner t1c (wywywy3@outlook.com), and the repository will be backed up before execution. The only drawback is the loss of revision history, which will inevitably dissatisfy many contributors. However, I hope everyone can compromise, as I believe alternative solutions are overly complex and raise the barrier to entry. We have also established a contributor list file and encourage everyone to actively participate.

rm -rf .git
git init
git add -A
git commit -m "Initial commit"
git push -u https://gitee.com/t1c/The_Due_of_Eras.git
