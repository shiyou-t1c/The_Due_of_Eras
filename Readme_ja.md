<!-- 
SPDX-FileCopyrightText: 2025 shiyou(t1c) and all contributors 
 
SPDX-License-Identifier: MIT 
-->
 
# エポック・デュエル 
 
[中文](Readme_zh.md)   | [English](Readme_en.md)   | [日本語](Readme_ja.md)  
 
### プロジェクト概要 
 
shiyou(t1c)(wywywy3@outlook.com):  
 
このコードの驚異的な点は、プログラミング知識がなくとも複雑なストーリー分岐システムと多言語対応を実現できることです。ハードウェアリソース消費量は市販のほとんどのギャルゲー製品を大幅に下回ります。プロジェクト推進のため、最低100人規模のチームが必要と見込まれます。この規模は私が構想した数百のストーリー分岐（各分岐が十分な物語深度を持つ）に起因します。プログラミング能力とシナリオ設計の水準において、私は読者であるあなたと同等かもしれません。生存競争にさらされる普通のサラリーマンとして、学生であれ996労働に縛られる方であれ、時間の貴重さを痛感しています。このプロジェクトを強制労働ではなく、創造の避難所と交流プラットフォームと位置づけたい。将来的にあなたが親友とこの事業を語り合う時、それが人生の輝かしい軌跡となることを約束します。
 
### ソフトウェアアーキテクチャ  
Godot 3.2.2を基盤とし、OpenGL ES 2.0レンダリングエンジンを採用。
 
Godot 3.2.2 安定版ダウンロード：
 
https://godotengine.org/download/archive/3.2.2-stable/  
 
バイナリファイルのエクスポートが不要な場合、"Export Templates"のダウンロードは省略可能。
 
### コントリビューションガイド  
 
開発フロー：
 
1. Godot 3.2.2フォークプロジェクトをダウンロードしリポジトリをクローン 
2. 新規ブランチを作成して開発 
3. コードをコミットしプルリクエストを発行 
 
プロジェクトは"b1.gd"スクリプトファイルのみを 含み、このスクリプトを読めば全体のロジックを把握可能。"b1p/b1.tres"ファイルの 内容を解析：
 
- #で始まる行：効果音再生 
- $で始まる行：背景切替
- ?で始まる行：選択肢ボタン生成
- &で始まる行：他ブランチへのジャンプ（空欄の場合は現ブランチ継続）
 
Gitブランチ開発例（"b1_1_2"ストーリーライン作成時）：
- `git branch b1_1_2`で新規ブランチ作成
- `git checkout b1_1_2`でブランチ切替 
- 開発完了後masterブランチに戻り`git merge b1_1_2`実行 
- コンフリクト発生時：
  1. `git status`で衝突ファイル特定 
  2. 手動編集で解決 
  3. マージコマンド再実行 
- マーチ成功後`git branch -d b1_1_2`でブランチ削除
 
現在必要とする役割：
- Godot 3.xエンジン開発者
- 原画師/UIデザイナー
- サウンドデザイナー/作曲家 
- シナリオライター
- 多言語翻訳者
 
民主的決定メカニズム：
- 強制労働時間なし
- 全決定は投票で確定 
- 非専門家のストーリー提案を歓迎
 
### ストーリー概要 
 
異世界帝国は豊かな天然資源と高度な農耕文明を有する。旧貴族からなる支配層が土地と政治権力を掌握。海外貿易の興隆と資本主義の萌芽に伴い、新興商人階級と郷紳層が台頭し、政治発言権と経済特権の拡大を志向。新興商人の代表として、あなたはこの社会的変革に参与します。
 
四大勢力：
- 商人ギルド：富と人脈を支配 
- 宰相グループ：行政権掌握 
- 革命軍：武力と民心を兼備 
- 皇室：軍事指揮権保有 
 
### ブランチ命名規則 
 
ストーリーブランチファイル命名規則（例："b1.tres" ）：
1. 全ブランチが"b1.tres"を 親ブランチ（ゲームエントリーポイント）として共有 
2. "b1.tres" 内の子ブランチは"b1_1.tres" 、"b1_2.tres"と 命名
3. 第二階層子ブランチは"b1_1_1.tres" 、"b1_1_2.tres" 形式 
 
多言語対応：
- 中国語ブランチファイルは"chinese"接尾辞（例："b1chinese.tres" ）
- 各言語ファイルは対応ディレクトリに格納 
 
リソース管理：
- 画像：/pictureディレクトリ、命名形式：ブランチ名+p+連番（例："b1_1p1.png" ）
- 複用画像命名：b1_1p4_and_b1_1_1p1.jpg   
- 効果音：/sound_effectsディレクトリ、命名形式：ブランチ名+言語ID+a+連番（例："b1_1chinese_a1.wav" ）
- 汎用効果音は言語ID省略（例："b1_1a1.wav" ）
 
### バイナリファイル管理 
 
ソフトウェア開発において、画像・動画・コンパイル済み実行ファイル等のバイナリファイルは不可欠ですが、バージョン管理システムへの直接保存はリポジトリ肥大化とパフォーマンス低下を招きます。効果的な管理方法の提案を募集中。
 
### 国際化問題 
 
物理的距離によるコードリポジトリアクセス遅延対策として、以下プラットフォームにメインリポジトリを設置：
- 中国国内ユーザー向けGitee：https://gitee.com/t1c/The_Due_of_Eras   
- 欧米ユーザー向けGitHub：https://github.com/shiyou-t1c/The_Due_of_Eras   
- グローバルカバレッジのSourceForge：https://sourceforge.net/p/the-due-of-eras/code/ci/master/tree/  
 
コード同期注意事項：
1. 同期前には全リポジトリの最新変更をプル
2. push.shスクリプト 参照（SSH非対称鍵設定要）
3. 各国ゲーム法規の差異により、プリコンパイル済みバイナリは提供不可 
 
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
