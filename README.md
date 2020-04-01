# NoticeBoard

掲示板アプリです。

## URL

https://www.notice-board-app.xyz/

ログインページ内テストログインボタンから、テストユーザーとしてログインできます。</br>
テストユーザーのみプロフィール情報を編集不可に設定しています。ご了承ください。</br>


## 使用技術

### 環境

* Ruby 2.5.7
* Rails 5.2.4
* postgreSQL
* Docker/docker-compose

### テスト

* RSpec

### インフラ

* AWS(VPC, EC2, RDS for postgreSQL, Route 53, ALB, ACM)
* Nginx
* Unicorn

### フロント

* SCSS
* Bootstrap4
* JQuery

### その他使用gem等

* Rubocop
* devise(ユーザーログイン機能)
* ransack(検索機能)
* kaminari(ページネーション)

## アプリケーションの機能

* ユーザー登録/ログイン機能
  - プロフィール編集
  - 管理ユーザー機能（一般ユーザーのアカウント、トピックを削除可能）
  - テストユーザー機能（testユーザーとしてログイン可、プロフィール編集不可制限）
* トピック投稿、閲覧機能
* コメント投稿機能（Ajax）
* カテゴリ設定機能
  - カテゴリ別一覧表示
* トピック検索機能(単語/トピック及びコメントから)
