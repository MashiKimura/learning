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
2. トップページの「追加する」から、教材内容(教材名・表示画像・学習するページ)を入力し、教材の登録を行う。
3. 登録が完了したらトップページに登録した教材の一覧が表示される。

## 学習記録登録
1. トップページの登録教材コンテンツの「記録」から学習記録(日付・学習時間・ページ・コメント)を入力し学習記録を登録する。
2. 登録完了したら、学習記録詳細ページにグラフと学習履歴に追加され表示される。

## 目標登録
1. 学習記録詳細ページの「目標を設定する」から目標学習時間を登録する。
2. 登録が完了したら「今週の学習」の項目が表示される。

# アプリケーションを作成した背景
自身の経験や友人へのヒアリングから「学習を始めてもなかなか継続できずに挫折してしまう」という課題を抱えていることが判明した。その原因として、無理な計画による計画倒れが挙げられるのではないかと仮説を立てた。つまり、学習を始める際に念入りに計画を立てるが、思った通りに学習が進まず、時間をかけて立てた計画が全くの無駄になってしまい、モチベーションを維持できずに、学習を継続できないのではないか、ということだ。この課題を解決するために、自身の学習記録から無理のない目先の目標を自動的に作成することで、計画倒れが発生しないような学習管理アプリを開発することにした。

# 洗い出した要件
[要件定義](https://docs.google.com/spreadsheets/d/1UyGfH1t4Il-dFLrofOh7sJAQpHHodvF2aaoOvmkVfNQ/edit?usp=sharing)
# 実装した機能についての画像やGIFおよびその説明

# 実装予定の機能

# データベース設計
[![Image from Gyazo](https://i.gyazo.com/3a90cf3c176fc3a880f28453b1d595ee.png)](https://gyazo.com/3a90cf3c176fc3a880f28453b1d595ee)
# 画面遷移図
[![Image from Gyazo](https://i.gyazo.com/d11a764c95fc13eac811b9c43db32cb4.png)](https://gyazo.com/d11a764c95fc13eac811b9c43db32cb4)
# 開発環境
- フロントエンド　HTML&CSS, Javascript
- バックエンド　ruby, Ruby on Rails
- インフラ　
- テスト　Rspec
- テキストエディタ　VisualStudioCode
- タスク管理　Github-ISSUE

# ローカルでの動作方法
以下のコマンドを順に実行。  
% git clone https://github.com/MashiKimura/learning.git  
% cd learning  
% bundle install  
% yarn install

# 工夫したポイント
    工夫したポイント
