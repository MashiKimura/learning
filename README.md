# アプリケーション名
Learning

# アプリケーション概要
自身の学習記録から短期的な学習目標を自動的に作成し、計画作りに労力を割くことなく目の前の学習に集中できる学習記録アプリ。

# URL
https://learning37327.herokuapp.com/

# テスト用アカウント
- Basic認証パスワード:mk1234
- Basic認証ID:Mkimura
- メールアドレス:testuser@email.com
- パスワード:a123456

# 利用方法
## 教材登録
1. トップページの「新規登録」からユーザー登録を行う。
2. トップページの「追加する」から教材の登録を行う。
3. 登録が完了したらトップページに登録した教材の一覧が表示される。

## 学習記録登録
1. トップページの登録教材コンテンツの「記録」から学習記録を登録する。
2. 登録完了したら、学習記録詳細ページにグラフと学習履歴に追加され表示される。

## 目標登録
1. 学習記録詳細ページの「目標を設定する」から目標学習時間を登録する。
2. 登録が完了したら「今週の学習」の項目が表示される。

# アプリケーションを作成した背景
自身の経験でもあるが、何かの学習を始めてもなかなか継続できずに挫折してしまう課題を
学習を始める際に計画を立てて学習を始めるが、思った通りに進まずせっかく立てた計画が全くの無駄になってしまい、結果学習を継続できないという課題を解決したいと考え開発を始めた。原因として
誰の：ヒアリング、自身の経験
概要：学習する人が挫折しないようなサポート
原因：学習を継続する上で計画倒れが多いのでは？
    ：計画をたてるのに時間がかかってしまい、
    ：その計画を守れず挫折してしまう。
手段：自動的に目標を設定してくれる

# 洗い出した要件

# 実装した機能についての画像やGIFおよびその説明

# 実装予定の機能

# データベース設計

# 画面遷移図

# 開発環境

# ローカルでの動作方法

# テーブル設計

## users テーブル
| Column              | Type    | Options                   |
| ------------------- |---------| ------------------------- |
| email               | string  | null: false, unique: true |
| encrypted_password  | string  | null: false               |
| nickname            | string  | null: false               |

### Association
- has_many :textbooks

## textbooks
| Column              | Type        | Options                         |
| ------------------- |------------ | ------------------------------- |
| book                | string      | null: false                     |
| s_page              | integer     | null: false                     |
| e_page              | integer     | null: false                     |
| user                | references  | null: false, foreign_key: true  |

### Association
- belongs_to :user
- has_many :records
- has_one :category
- has_one :df_time
- has_many :his_times

## categorys
| Column              | Type           | Options                         |
| ------------------- |--------------- | ------------------------------- |
| c_name              | string         | null: false                     |
| textbook            | references     | null: false, foreign_key: true  |

### Association
- belongs_to :textbook

## records
| Column              | Type        | Options                         |
| ------------------- |------------ | ------------------------------- |
| r_date              | date        | null: false                     |
| hours               | integer     | null: false                     |
| minutes             | integer     | null: false                     |
| r_page              | integer     | null: false                     |
| r_text              | string      | null: false                     |
| textbook            | references  | null: false, foreign_key: true  |

### Association
- belongs_to :textbook

## df_times
| Column              | Type        | Options                         |
| ------------------- |---------- -- | ------------------------------- |
| d_sun               | integer     | null: false                     |
| d_mon               | integer     | null: false                     |
| d_tue               | integer     | null: false                     |
| d_wed               | integer     | null: false                     |
| d_thu               | integer     | null: false                     |
| d_fri               | integer     | null: false                     |
| d_sat               | integer     | null: false                     |
| textbook            | references  | null: false, foreign_key: true  |

### Association
- belongs_to :textbook

## his_times
| Column              | Type        | Options                         |
| ------------------- |------------ | ------------------------------- |
| his_date            | date        | null: false                     |
| h_sun               | integer     | null: false                     |
| h_mon               | integer     | null: false                     |
| h_tue               | integer     | null: false                     |
| h_wed               | integer     | null: false                     |
| h_thu               | integer     | null: false                     |
| h_fri               | integer     | null: false                     |
| h_sat               | integer     | null: false                     |
| textbook            | references  | null: false, foreign_key: true  |

### Association
- belongs_to :textbook
