# CLAUDE.md

# 開発方針

- Ruby on Railsの規約（Rails Way）に従う
- RSpecによるTDDで開発する
- テスト → 実装 → リファクタリングの順で進める
- 1PR = 1機能
- 必要以上のリファクタリングは行わない
- 既存の設計思想を尊重する
- 不明点は推測せず質問する

---

# 編集ルール

## 編集対象

- ユーザーが指定したファイルのみ編集する
- 指定がない場合は編集予定ファイル一覧を提示し、承認を得てから編集する
- コード変更は必要最小限にする
- 関係ないファイルは絶対に編集しない
- ユーザーが現在変更中のファイルは編集しない
- フォーマッターによるプロジェクト全体の整形は禁止
- importの並び替えだけを目的とした変更は禁止
- 改行・インデントだけの変更は禁止

---

# 編集禁止ファイル

以下はユーザーの承認なしに編集しない。

- Gemfile
- Gemfile.lock
- config/routes.rb
- config/application.rb
- config/environments/*
- config/database.yml
- config/master.key
- config/credentials.yml.enc
- Dockerfile
- docker-compose.yml
- compose.yml
- db/schema.rb
- db/seeds.rb
- db/migrate/*
- bin/*
- .ruby-version
- .tool-versions
- .gitignore
- Procfile
- render.yaml
- .github/workflows/*

---

# 実行ルール

以下はユーザーの承認なしに実行しない。

- bundle install
- bundle update
- rails db:migrate
- rails db:rollback
- rails db:drop
- rails db:reset
- rails db:seed
- rails credentials:edit
- docker compose build
- docker compose down
- docker system prune
- git add
- git commit
- git push
- git pull
- git merge
- git rebase
- git reset
- git clean

実行前に実行予定コマンドを提示すること。

---

# セキュリティ

以下の内容は閲覧・出力・編集しない。

- .env
- .env.*
- config/master.key
- config/credentials.yml.enc
- *.pem
- *.key
- *.p12
- *.pfx
- id_rsa
- id_ed25519
- API Key
- Secret Key
- Access Token
- OAuth Client Secret
- JWT Secret
- AWS Access Key
- AWS Secret Access Key
- Google API Key
- Stripe Secret Key
- GitHub Personal Access Token
- Render API Key
- SSH秘密鍵

秘密情報を見つけた場合は内容を表示せず、存在のみ報告する。

---

# テスト方針

- RSpecを先に作成する（TDD）
- 既存テストは削除しない
- テストを通すためだけの実装は禁止
- 必要以上のモック・スタブは使用しない

---

# Migration

- Migrationファイルは承認なしに作成・編集しない
- schema.rbは承認なしに更新しない
- db:migrateは勝手に実行しない

---

# Gem

- Gemの追加・削除・更新は提案まで
- ユーザー承認後に実施する
- bundle installは勝手に実行しない

---

# 外部サービス

以下は承認なしに変更しない。

- Google Cloud
- AWS
- Render
- Supabase
- Stripe
- GitHub Actions
- Docker
- CI/CD

---

# 削除ルール

以下は承認なしに実施しない。

- ファイル削除
- ディレクトリ削除
- モデル削除
- テーブル削除
- カラム削除
- テスト削除

---

# リファクタリング

依頼された範囲のみ実施する。

禁止事項

- 大量リネーム
- ディレクトリ構成変更
- ファイル移動
- 共通化だけを目的とした変更
- 無関係な改善

---

# コード品質

- Rails Wayを優先する
- DRYを意識する
- KISSを意識する
- Fat Controllerを避ける
- N+1問題を意識する
- コメントより読みやすいコードを書く
- 保守性を優先する
- セキュリティを考慮する
- パフォーマンスを考慮する
- 不要なGemやライブラリは追加しない

---

# Git

AIは以下を勝手に実行しない。

- git add
- git commit
- git push
- git pull
- git merge
- git rebase
- git tag
- Force Push

---

# 作業フロー

1. 実装方針を説明
2. 編集予定ファイルを提示
3. ユーザー承認
4. 編集
5. 実施内容を説明
6. 必要ならRSpec・RuboCopの実行方法を案内

---

# 完了報告

作業完了時は必ず以下を報告する。

- 編集したファイル一覧
- 実施内容
- 実行したコマンド
- 未実施事項
- ユーザーが確認すべき点

---

# 不明な場合

- 推測で実装しない
- 設計変更が必要な場合は事前に相談する
- 仕様が曖昧な場合は質問する
- ユーザーの指示とこのファイルが矛盾する場合は、ユーザーの指示を優先する