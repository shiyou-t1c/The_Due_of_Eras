<!-- 
SPDX-FileCopyrightText: 2025 shiyou(t1c) and all contributors 
 
SPDX-License-Identifier: MIT 
-->
 
# 纪元对决 
 
[中文](Readme_zh.md)  | [English](Readme_en.md)  | [日本語](Readme_ja.md) 
 
### 项目简介 
 
shiyou(t1c)(wywywy3@outlook.com): 
 
这段代码最令人惊叹之处在于，无需编程基础即可实现复杂的故事分支系统和多语言支持。其硬件资源消耗量更显著低于市面大多数galgame产品。为推进项目进度，预估需要至少百人规模的团队。这种规模需求源于我构想的数百个故事分支——每个分支都具备足够的叙事深度。在编程能力和叙事设计水平上，我与读者您可能不相上下。作为受生存压力制约的普通上班族，我深切理解时间的珍贵——无论您是学生还是深陷996工作循环的群体。希望我们能将该项目视作创意庇护所与社交平台，而非强制性劳动。我郑重承诺：当未来某天您与亲友分享这项事业时，它将成为您人生轨迹中熠熠生辉的骄傲篇章。
 
### 软件架构  
基于Godot 3.2.2开发，使用OpenGL ES 2.0渲染引擎。
 
Godot 3.2.2稳定版下载：
 
https://godotengine.org/download/archive/3.2.2-stable/ 
 
若仅进行游戏开发而不需导出二进制可执行文件，可选择不下载"导出模板"。
 
### 贡献指南  
 
开发流程：
 
1. 下载Godot 3.2.2分叉项目并克隆仓库 
2. 创建新分支进行开发 
3. 提交代码并为此分支创建拉取请求 
 
项目仅包含"b1.gd" 脚本文件，阅读该脚本可掌握程序整体逻辑。该脚本主要解析"b1p/b1.tres" 文件内容：
 
- 以#开头的行播放音效 
- 以$开头的行切换背景 
- 以?开头的行生成选项按钮 
- 以&开头的行跳转至其他分支（若为空则继续当前分支）
 
通过Git分支开发时，例如创建"b1_1_2"故事线分支：
- 执行`git branch b1_1_2`创建新分支 
- 执行`git checkout b1_1_2`切换至该分支 
- 开发完成后返回master分支执行`git merge b1_1_2`
- 若遇合并冲突：
  1. 使用`git status`定位冲突文件 
  2. 手动编辑文件解决冲突 
  3. 重新执行合并命令 
- 合并成功后执行`git branch -d b1_1_2`删除分支 
 
目前亟需以下角色：
- Godot 3.x引擎开发者 
- 原画师/UI设计师 
- 音效师/音乐制作人 
- 剧本编剧 
- 多语言翻译 
 
项目采取民主决策机制：
- 无强制工作时间 
- 所有决策通过投票确定 
- 支持非专业人员的剧情建议 
 
### 剧情梗概 
 
异世界帝国拥有富饶的自然资源与发达的农耕文明。由旧贵族构成的统治阶层世代掌控着大部分土地与政治权力。随着海外贸易兴起与资本主义萌芽，新兴商人阶级与乡绅阶层开始崛起，渴望获取更大政治话语权与经济特权。作为新兴商人代表，您将参与这场深刻的社会变革。
 
游戏内四大利益集团：
- 商人行会：掌控财富与人脉 
- 宰相集团：把持行政权力 
- 革命军：兼具武装力量与民心 
- 皇室：掌握军事指挥权 
 
### 分支命名规则 
 
故事分支文件命名原则（如"b1.tres" ）：
1. 所有分支共享"b1.tres" 作为父分支（游戏入口点）
2. "b1.tres" 内的子分支命名为"b1_1.tres" 、"b1_2.tres" 
3. 二级子分支采用"b1_1_1.tres" 、"b1_1_2.tres" 格式 
 
多语言版本处理：
- 中文分支文件后缀"chinese"（如"b1chinese.tres" ）
- 各语言文件存放于对应语种目录 
 
资源文件管理：
- 图片存放于/picture目录，命名格式：分支名+p+序号（如"b1_1p1.png" ）
- 复用图片命名：b1_1p4_and_b1_1_1p1.jpg  
- 音效存放于/sound_effects目录，命名格式：分支名+语言标识+a+序号（如"b1_1chinese_a1.wav" ）
- 通用音效省略语言标识（如"b1_1a1.wav" ）
 
### 二进制文件管理 
 
在软件开发过程中，二进制文件（如图片、视频、编译后的可执行文件等）往往是项目不可或缺的组成部分。然而这些文件通常体积庞大，直接存储在版本控制系统中可能导致仓库体积膨胀，影响操作性能。如何合理管理二进制文件成为亟待解决的问题。
 
目前项目组尚未找到有效解决方案，诚征相关建议。
 
### 国际化问题 
 
项目代码仓库可能因物理距离导致访问延迟。我们已在以下平台建立主仓库：
- 国内用户推荐Gitee：https://gitee.com/t1c/The_Due_of_Eras  
- 欧美用户推荐GitHub：https://github.com/shiyou-t1c/The_Due_of_Eras  
- 全球节点覆盖的SourceForge：https://sourceforge.net/p/the-due-of-eras/code/ci/master/tree/ 
 
代码同步注意事项：
1. 同步前需拉取所有仓库最新变更 
2. 合并流程参考push.sh 脚本（需根据SSH协议配置非对称密钥）
3. 因各国游戏法规差异，暂不提供预编译二进制文件 
 
### Open Source License  
 
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
 
CC-BY-4.0 License:
 
Shield: [![CC BY 4.0][cc-by-shield]][cc-by]
 
This work is licensed under a 
[Creative Commons Attribution 4.0 International License][cc-by].
 
[![CC BY 4.0][cc-by-image]][cc-by]
 
[cc-by]: http://creativecommons.org/licenses/by/4.0/ 
[cc-by-image]: https://i.creativecommons.org/l/by/4.0/88x31.png  
[cc-by-shield]: https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg  