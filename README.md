# StockDish

## 概要

StockDish(ストックディッシュ)は、家庭にある調味料・食材を登録し、OpenAI APIを使ってレシピを提案してもらえるWebアプリケーションです。

ユーザーが手動で食材・調味料を登録 → AIがレシピを提案 → 提案されたレシピを保存・蓄積していくことで、ユーザー間で共有されるレシピDBが育っていく、というコンセプトで開発しています。

## 技術スタック

| 領域 | 技術 |
|---|---|
| 言語/フレームワーク | Ruby 3.4 / Rails 8.1.3 |
| DB | PostgreSQL |
| フロントエンド | ERB + Tailwind CSS |
| AI | OpenAI API |
| インフラ | Docker / Render |
| 認証 | has_secure_password(自前実装) |

### 技術選定の理由

**なぜRailsか**
学習効率と開発スピードを重視。Railsの規約(Convention over Configuration)に従うことで、MVCの責務分離を実践的に学べると考えたため。

**なぜhas_secure_passwordか(Deviseではなく)**
Deviseは便利だが内部処理がブラックボックス化しやすい。認証の仕組み(パスワードのハッシュ化、セッション管理など)を自分で実装することで、Webアプリのセキュリティの基礎を理解する目的で採用。

**なぜPostgreSQLか**
Renderでのデプロイを想定し、本番環境でも安定して使える点、Railsとの相性の良さから選定。

## 今後の拡張予定

MVPリリース後、以下の構成への移行を計画しています。

- バックエンド: Rails API モード化
- フロントエンド: React(Next.js)へ移行
- 画像認識: 冷蔵庫の写真から食材を自動認識するFastAPIマイクロサービスを追加
- インフラ: AWS(EC2 / RDS / S3)+ Nginx + Redis + GitHub Actionsでの本番運用

## DB設計

7つのテーブルで構成しています。

```mermaid
erDiagram
    users ||--o{ user_ingredients : has
    users ||--o{ user_seasonings : has
    users ||--o{ user_recipes : has
    ingredients ||--o{ user_ingredients : "registered as"
    seasonings ||--o{ user_seasonings : "registered as"
    recipes ||--o{ user_recipes : "bookmarked as"

    users {
        int id
        string name
        string email
        string password_digest
    }
    ingredients {
        int id
        string name
        int default_expiry_days
    }
    seasonings {
        int id
        string name
        int default_expiry_days
    }
    user_ingredients {
        int id
        int user_id
        int ingredient_id
        date expiry_date
    }
    user_seasonings {
        int id
        int user_id
        int seasoning_id
        date expiry_date
    }
    recipes {
        int id
        string title
        text content
    }
    user_recipes {
        int id
        int user_id
        int recipe_id
    }
```

### テーブル概要

- **users**: ユーザー情報(認証含む)
- **ingredients / seasonings**: 食材・調味料のマスタデータ(共有DB)
- **user_ingredients / user_seasonings**: ユーザーごとの在庫(中間テーブル)
- **recipes**: OpenAI APIで生成されたレシピ(共有DB、ユーザー間で蓄積)
- **user_recipes**: ユーザーがブックマークしたレシピ(中間テーブル)

`ingredients`と`seasonings`はユーザー間で共有されるマスタデータとして設計し、登録されたデータがアプリ全体の資産として蓄積されていく構成になっています。