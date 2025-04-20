# The_Duel_of_Eras

#### Introduction  
The Duel of Eras  

#### Software Architecture  
Developed with Godot 3.2.2, using OpenGL ES 2.0.  

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



Currently, we need programmers familiar with the Godot 3.x engine, artists, sound designers, scriptwriters, and music producers. Of course, we are currently unable to pay any salaries. 

We don’t have strict working hours, and all decisions are made through voting. Therefore, everyone can contribute code easily without too much pressure. Even if you’re not a professional, you can still provide suggestions for the storyline.

### Plot summary

The empire of another world is blessed with abundant natural resources and thriving agriculture. The ruling class of the kingdom consists of old nobility, whose families have controlled most of the land and political power for generations. However, with the rise of overseas trade and the emergence of capitalism, a new merchant class and landed gentry have begun to ascend, eager to gain greater political influence and economic privileges. As a rising merchant, you participate in this era of profound societal change. 

### Requirements for Background

Difficulty Analysis: 
The price range for a single anime-style illustration might be approximately between $143 ~ $1286. Individuals willing to work for free for us may not exist. Contributors who can utilize large AI models for drawing to locally generate high-quality images meeting requirements (web-based AI generation might have copyright issues) would be highly welcomed. Currently, most people's GPUs are insufficient to support local AI text-to-image generation, which presents a challenge. The second challenge is that we require character design sheets, with consistent depictions of fixed characters across different scenarios. While separating character layers from background layers might facilitate AI generation, this approach could create lighting inconsistencies between characters and environments, potentially necessitating manual adjustments. No solution currently exists for this issue - those with potential solutions are invited to join our Microsoft Teams online meeting.

Artists may include their signature (artist name and artwork title) and date (completion date) in the corner of the image. However, these markings must not occupy too much space within the frame.All images must be clear with no obvious blurring, stretching, compression, black edges, white edges, etc.The background image must have a resolution of 1280*720.Include attribution if using third-party assets.Third-party materials may involve copyright issues and are not recommended for use. It's best to obtain a license that allows free commercial use.）

### Requirements for Audio

Format & Quality:
    Must be in .wav or .mp3 format.
    No distortion, clipping, or background noise.


Content:
    Voice recordings must be clear, with proper pacing and enunciation.
    Music/SFX should match the tone of the scene (e.g., suspenseful music for tense moments).


Metadata:
    Label files clearly (e.g., SFX_DoorKnock_01.wav).
    Include attribution if using third-party assets.（Third-party materials may involve copyright issues and are not recommended for use. It's best to record your own audio or obtain a license that allows free commercial use.）


### Requirements for Script

The improvements to the program and the storyline mainly involve modifying the b1.gd and b1p/b1.tres files. If you have any suggestions, you can help us by submitting issues or pull requests.

### Branch Naming Rules

Here we are discussing narrative branches, not Git repository branches. Specifically, the naming rules for branch files such as "b1.tres". The key principle is that all branches share "b1.tres" as their parent branch. "b1.tres" serves as the entry point for the entire game. Branches within the "b1.tres" file will be named as "b1_1.tres", "b1_2.tres", etc., indicating their status as child branches of "b1.tres". Similarly, branches within the "b1_1.tres" file will be named "b1_1_1.tres", "b1_1_2.tres", and so forth.

For different language versions, the filename must include a language identifier. For example, Chinese versions should be labeled as "b1chinese.tres" or "b1_1_1chinese.tres", and these files should be placed in corresponding directories for their respective languages.

Images need to be placed in the "picture" folder, named by appending "p" and a number directly after the current branch name. For example, in the branch file "b1_1english.tres", since images are language-agnostic, we omit the language identifier. Thus, they should be named like "b1_1p1.png", "b1_1p2.png". If an image is reused across branches, name it as "b1_1p4_and_b1_1_1p1.jpg". Audio files should be placed in the "sound_effects" folder, named by appending "a" and a number directly after the current branch name. Since audio may be language-dependent, we retain the language identifier. For example, "b1_1chinese_a1.wav". For language-agnostic audio, name them like "b1_1a1.wav".If an audio file is reused, it should be named like "b1_1chinese_a1_and_b1_1_1a1.wav".

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
- SourceForge has global server nodes.(read-only)

On SourceForge, projects imported from GitHub are by default set up as read-only mirror repositories. This means that updates from the source project are automatically synchronized to SourceForge, but it is not possible to directly modify or submit code on SourceForge. Currently, we are primarily developing on GitHub and Gitee, and we still need to conduct various experiments to test the stability of both platforms.
