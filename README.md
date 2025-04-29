<!--
SPDX-FileCopyrightText: 2025 shiyou and all contributors

SPDX-License-Identifier: MIT
-->

# The_Duel_of_Eras

#### Introduction

shiyou(t1c):

The most astonishing aspect of this code lies in its ability to implement complex branching story systems and multilingual support without requiring programming expertise. Equally remarkable is its minimal hardware resource consumption, significantly lower than most galgame products currently on the market. To expedite the project’s progress, I estimate the need for a team of at least 100 members. This scale is essential due to my vision of creating hundreds of story branches, each with substantial narrative depth. In terms of programming skills and narrative design capabilities, I am likely no more advanced than you, the reader. As an ordinary office worker constrained by survival pressures, I deeply empathize with the preciousness of time—whether you are a student or someone trapped in the grueling 9-9-6 work cycle. I hope we can approach this project as a creative sanctuary and a social hub, rather than a mandatory labor. I solemnly pledge that one day in the future, when you share this endeavor with loved ones, it will stand as a radiant chapter of pride in your life’s journey.

#### Software Architecture  
Developed with Godot 3.2.2, using OpenGL ES 2.0.

Download Godot 3.2.2 stable :

https://godotengine.org/download/archive/3.2.2-stable/

If you only want to develop games and do not need to export your project as a binary executable file, you can choose not to download the "Export Templates".

#### Contributing  

Development Guide:

You need to understand the current urgent needs, which are the current work tasks. We release tasks in the form of meetings through Microsoft Teams communities. If someone wants to take responsibility, they can claim the task, just like picking up a quest in a guild in a game. You can join the community via the following link:


https://teams.live.com/l/community/FEAwT0gP3U1us8cPgI


Download the Godot 3.2.2 fork project and clone the forked repository.
Create a new branch and develop on this branch.
Commit your code and submit a pull request for this branch.

The project consists of only one script, "b1.gd." Reading this script will give you a general understanding of the entire program.
The script primarily reads content from the "b1p/b1.tres" file:

1.Lines starting with # play a sound.

2.Lines starting with $ change the background.

3.Lines starting with ? provide choice buttons.

4.Lines starting with & jump to another branch (if empty, continue the current branch).

When developing via Git branches, for example, if you want to create a branch for the "b1_1_2" storyline, you can run `git branch b1_1_2`. This command creates a new branch but does not switch to it. To switch to the branch, execute `git checkout b1_1_2`, which moves the HEAD pointer to the latest commit on the `b1_1_2` branch.  

After completing development, switch back to the `master` branch with `git checkout master`, then merge the `b1_1_2` branch using `git merge b1_1_2`. Occasionally, conflicts may arise during merging—for instance, if someone modified the same part of a file in the `master` branch while you were working on `b1_1_2`. To resolve this:  
1. Use `git status` to identify conflicting files.  
2. Open the files and manually resolve the conflicts by either retaining changes from one branch or editing the conflicting sections.  
3. Re-run `git merge` after resolving conflicts.  

Once the `b1_1_2` branch has been successfully merged into `master`, delete it with `git branch -d b1_1_2`.  

Currently, we need programmers familiar with the Godot 3.x engine, artists, sound designers, scriptwriters, and music producers. Of course, we are currently unable to pay any salaries.

We don’t have strict working hours, and all decisions are made through voting. Therefore, everyone can contribute code easily without too much pressure. Even if you’re not a professional, you can still provide suggestions for the storyline.

### Plot summary

The empire of another world is blessed with abundant natural resources and thriving agriculture. The ruling class of the kingdom consists of old nobility, whose families have controlled most of the land and political power for generations. However, with the rise of overseas trade and the emergence of capitalism, a new merchant class and landed gentry have begun to ascend, eager to gain greater political influence and economic privileges. As a rising merchant, you participate in this era of profound societal change.

### Branch Naming Rules

Here we are discussing narrative branches, not Git repository branches. Specifically, the naming rules for branch files such as "b1.tres". The key principle is that all branches share "b1.tres" as their parent branch. "b1.tres" serves as the entry point for the entire game. Branches within the "b1.tres" file will be named as "b1_1.tres", "b1_2.tres", etc., indicating their status as child branches of "b1.tres". Similarly, branches within the "b1_1.tres" file will be named "b1_1_1.tres", "b1_1_2.tres", and so forth.

For different language versions, the filename must include a language identifier. For example, Chinese versions should be labeled as "b1chinese.tres" or "b1_1_1chinese.tres", and these files should be placed in corresponding directories for their respective languages.

Images need to be placed in the "picture" folder, named by appending "p" and a number directly after the current branch name. For example, in the branch file "b1_1english.tres", since images are language-agnostic, we omit the language identifier. Thus, they should be named like "b1_1p1.png", "b1_1p2.png". If an image is reused across branches, name it as "b1_1p4_and_b1_1_1p1.jpg". Audio files should be placed in the "sound_effects" folder, named by appending "a" and a number directly after the current branch name. Since audio may be language-dependent, we retain the language identifier. For example, "b1_1chinese_a1.wav". For language-agnostic audio, name them like "b1_1a1.wav".If an audio file is reused, it should be named like "b1_1a1_and_b1_1_1a1.wav".

### Contact and Networks

Although email is a convenient way to contact us, we also provide an online community for discussions and Q&A. We use Microsoft Teams—here’s the invitation link:


https://teams.live.com/l/community/FEAwT0gP3U1us8cPgI

### Regarding the Handling of Binary Files

In the software development process, binary files (such as images, videos, compiled executable files, etc.) are often an indispensable part of the project. However, these files are usually large in size, and storing them directly in the version control system may cause the warehouse to expand in size, affecting performance. Therefore, it is crucial to manage binary files reasonably.

At present, our project team has not found a solution to this problem. I hope to receive some suggestions.

### Regarding the issue of internationalization

The code repository of the project may have slow server speed due to distance, regardless of where it is posted.

We have open-sourced the project on three platforms:

1. https://sourceforge.net/p/the-due-of-eras/code/ci/master/tree/

2. https://github.com/shiyou-t1c/The_Due_of_Eras

3. https://gitee.com/t1c/The_Due_of_Eras


Among these:
- Gitee offers faster access speeds within China.
- GitHub provides better performance in Europe and the Americas.
- SourceForge has global server nodes.

Each code repository is a main repository, so before synchronizing the code, ensure to pull the latest changes from every repository and perform a merge.The process is similar to what is described in "push.sh", but you need to modify it based on your specific scenario. While I use the SSH protocol, you should configure your own asymmetric keys to achieve the same purpose.

The reason we do not provide pre-compiled binary executable files is because the laws regarding games vary by country, and distributing binary executable files may violate legal regulations.


#### Open Source License  

MIT License:  

Copyright (c) [2025] [shiyou and all contributors]  

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal  
in the Software without restriction, including without limitation the rights  
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell  
copies of the Software, and to permit persons to whom the Software is  
furnished to do so, subject to the following conditions:  

The above copyright notice and this permission notice shall be included in all  
copies or substantial portions of the Software.  

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,  
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE  
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER  
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,  
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
