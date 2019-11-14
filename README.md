GitHub API, ZenHub API, CircleCI APIを利用してソフトウェア開発のメトリクスを取得し分析するためのスクリプトを集めたレポジトリです。

参考: 
- [LeanとDevOpsの科学[Accelerate] テクノロジーの戦略的活用が組織変革を加速する](https://amzn.to/2OdL803)
- [The DevOps ハンドブック 理論・原則・実践のすべて](https://amzn.to/374Fq9t)

シェルスクリプトを走らせてメトリクスを収集し、CSVファイルを作ります。CSVファイルの分析はGoogle Spreadsheetを使うと楽でしょう。

<img width="1147" alt="スクリーンショット 2019-11-15 3 48 02" src="https://user-images.githubusercontent.com/7414320/68886566-cf06c580-075a-11ea-83c5-d1df3c20fa39.png">

## なんでZenHubのレポートに頼らないの？

2019年11月14日現在、まだZenHubレポートのカスタマイズ性が低く、必要な情報をレポートで表示することができません。
上記2冊の参考図書をもとに、ソフトウェア開発のためのメトリクスをすべて取得するためにはAPIから情報を取得する以外にありませんでした。

## 使い方

### 事前セットアップ

- [GitHub personal token](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line)を用意します、これはGitHub APIにアクセスする際に[Authentication](https://developer.github.com/v3/#authentication)が必要となるためです
- 上記のGitHub personal tokenを`env.json`に保存してください。`env.json`の作り方は`env.default.json`を参考にしてください
- `setup_gitup_repo.sh`を実行します
  - あなたが`your_org/my_repo`というGitHubレポジトリのメトリクスを分析したいとします
  - その場合シンタックスは`./setup_github_repo.sh your_org my_repo`です
  - これで`data/your_org/my_repo`ディレクトリが作成され、必要なファイルがコピーされます
- `cd data/your_org/my_repo`で移動してください

### GitHub Pull Request分析

- `cd data/your_org/my_repo`で移動したものと仮定します
- `data`以下のディレクトリは`.gitignore`で無視されるので、このディレクトリで行う作業はすべてgitには保存されません
- このディレクトリで`env.json`に以下の3つのフィールドが正しく値を持つことを確認してください、これがないとGitHub APIが叩けません
```
{
  "github_token": "*********************************",
  "github_organization": "your_org",
  "github_repository": "my_repo"
}

```
- `./pulls.sh`を実行してください、これでpull requestの一覧を取得し`pulls.json`に保存します(現状30件しか取得してくれません)
- `./pulls_expand_all.sh`を実行してください、これで各pull requestの詳細を`data/your_org/my_repo/pulls`以下に保存します

<img width="100" src="https://user-images.githubusercontent.com/7414320/68888113-a7fdc300-075d-11ea-8d55-31a75378fbc5.png">

- `./pulls_convert_to_csv.sh`を実行してください、CSVが出力されます
- CSVをGoogle SpreadSheetに貼り付け、分析してください
- Google SpreadSheetの"Explore"ボタンを使うと、Googleの機械学習エンジンがヒストグラムや散布図などデータにてきたグラフをサジェストしてくれます。すごいです。[この動画](https://youtu.be/e7ilmKzfFNg?t=1506)にも解説があります
<img width="191" alt="スクリーンショット 2019-11-15 4 23 57" src="https://user-images.githubusercontent.com/7414320/68889196-c795eb00-075f-11ea-84d6-067265704d31.png">

### Circle CI分析

### ZenHub分析
