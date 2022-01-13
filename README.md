# テーブル設計

## users テーブル
| Column              | Type    | Options                   |
| ------------------- |---------| ------------------------- |
| email               | string  | null: false, unique: true |
| encrypted_password  | string  | null: false               |
| nickname            | string  | null: false               |
| birth_day           | date    | null: false               |

### Association
- has_one :setting
- has_many :s_learnings

## settings
| Column              | Type        | Options                       |
| ------------------- |------------ | ----------------------------- |
| s_day               | string      | null: false                   |
| user                | references  | null: false, foreign_key: true |

### Association
- belongs_to :user

## s_learnings
| Column              | Type        | Options                         |
| ------------------- |------------ | ------------------------------- |
| subject             | string      | null: false                     |
| g_date              | date        |                                 |
| user                | references  | null: false, foreign_key: true  |

### Association
- belongs_to :user
- has_many :textbooks

## textbooks
| Column              | Type        | Options                         |
| ------------------- |------------ | ------------------------------- |
| book                | string      | null: false                     |
| s_page              | integer     | null: false                     |
| e_page              | integer     | null: false                     |
| s_date              | date        | null: false                     |
| e_date              | date        | null: false                     |
| s_learning          | references  | null: false, foreign_key: true  |

### Association
- belongs_to :s_learning
- has_many :records
- has_many :w_goals

## records
| Column              | Type        | Options                         |
| ------------------- |------------ | ------------------------------- |
| rs_date             | datetime    | null: false                     |
| re_date             | datetime    | null: false                     |
| rs_page             | integer     | null: false                     |
| re_page             | integer     | null: false                     |
| textbook            | references  | null: false, foreign_key: true  |

### Association
- belongs_to :textbook

## w_goals
| Column              | Type        | Options                         |
| ------------------- |------------ | ------------------------------- |
| ws_date             | date        | null: false                     |
| we_date             | date        | null: false                     |
| w_time              | integer     | null: false                     |
| w_page              | integer     | null: false                     |
| speed               | integer     | null: false                     |
| achief_r            | float       | null: false                     |
| textbook            | references  | null: false, foreign_key: true  |

### Association
- belongs_to :textbook

