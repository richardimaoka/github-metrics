GitHub API, ZenHub API, CircleCI APIを利用してソフトウェア開発のメトリクスを取得し分析するためのスクリプトを集めたレポジトリです。

参考: 
- [LeanとDevOpsの科学[Accelerate] テクノロジーの戦略的活用が組織変革を加速する](https://amzn.to/2OdL803)
- [The DevOps ハンドブック 理論・原則・実践のすべて](https://amzn.to/374Fq9t)

シェルスクリプトを走らせてメトリクスを収集し、CSVファイルを作ります。CSVファイルの分析はGoogle Spreadsheetを使うと楽でしょう。

<img width="1147" alt="スクリーンショット 2019-11-15 3 48 02" src="https://user-images.githubusercontent.com/7414320/68886566-cf06c580-075a-11ea-83c5-d1df3c20fa39.png">

## 使い方

- [GitHub personal token](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line)を用意します、これはGitHub APIにアクセスする際に[Authentication](https://developer.github.com/v3/#authentication)が必要となるためです
- 上記のGitHub personal tokenを`env.json`に保存してください。`env.json`の作り方は`env.default.json`を参考にしてください
- `setup_gitup_repo.sh`を実行します
  - あなたが`your_org/my_repo`というGitHubレポジトリのメトリクスを分析したいとします
  - その場合シンタックスは`./setup_github_repo.sh your_org my_repo`です
  - これで`data/your_org/my_repo`ディレクトリが作成され、必要なファイルがコピーされます
- `cd data/your_org/my_repo`で移動してください

