## 概要

Git リポジトリを特定のアカウントに切り替えるスクリプトです。

## インストール

1. **スクリプトの配置**
   `Switch-ToPersonalGit` を任意の `.ps1` ファイルに保存するか、プロファイル (`$PROFILE`) に直接追加してください。

2. **.env の作成**
   スクリプトと同じフォルダーに次の形式で `.env` を作成してください。

   ```env
   # コメント行は無視されます
   GIT_NAME=Your Name
   GIT_EMAIL=your.name@example.com
   ```

## 使い方

```powershell
# リポジトリのルートで実行
Switch-ToPersonalGit        # もしくは 'spgit'
```

実行に成功すると、以下のような情報メッセージが表示されます。

```text
✅ Local Git profile set: Your Name <your.name@example.com>
```

## エラー例

| 状況             | メッセージ                               | 解決策                   |
| -------------- | ----------------------------------- | --------------------- |
| Git 未インストール    | `git command not found`             | Git をインストールし、PATH を通す |
| `.git` フォルダーなし | `Not inside a Git repository`       | リポジトリ直下で実行する          |
| `.env` 不在      | `.env file not found`               | `.env` を作成する          |
| 変数不足           | `GIT_NAME or GIT_EMAIL not defined` | `.env` に両方定義する        |
