# アプリケーション名
learning

# アプリケーション概要

# URL

# テスト用アカウント

# 利用方法

# アプリケーションを作成した背景

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
| r_time              | time        | null: false                     |
| r_page              | integer     | null: false                     |
| r_text              | integer     | null: false                     |
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