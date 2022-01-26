require 'rails_helper'

RSpec.describe Textbook, type: :model do
  before do
    @textbook = FactoryBot.build(:textbook)
  end

  describe '教材登録' do
    context '教材の登録ができるとき' do
      it '全ての項目が入力されていれば登録できる' do
        @textbook.valid?
        expect(@textbook).to be_valid
      end
      it '画像がなければ登録できる' do
        @textbook.image = nil
        expect(@textbook).to be_valid
      end
    end
    context '教材の登録ができないとき' do
      it '教材名が空では登録できない' do
        @textbook.book = ''
        @textbook.valid?
        expect(@textbook.errors.full_messages).to include("Book can't be blank")
      end
      it '教材名が50文字を超えては登録できない' do
        @textbook.book = 'aaaaabbbbbcccccdddddeeeeefffffggggghhhhhiiiiijjjjjk'
        @textbook.valid?
        expect(@textbook.errors.full_messages).to include("Book is too long (maximum is 50 characters)")
      end
      it '学習開始ページが空では登録できない' do
        @textbook.s_page = ''
        @textbook.valid?
        expect(@textbook.errors.full_messages).to include("S page can't be blank")
      end
      it '学習開始ページが３桁を超えると登録できない' do
        @textbook.s_page = 1000
        @textbook.valid?
        expect(@textbook.errors.full_messages).to include("S page must be less than or equal to 999")
      end
      it '学習終了ページが空では登録できない' do
        @textbook.e_page = ''
        @textbook.valid?
        expect(@textbook.errors.full_messages).to include("E page can't be blank")
      end
      it '学習終了ページが4桁を超えると登録できない' do
        @textbook.e_page = 10000
        @textbook.valid?
        expect(@textbook.errors.full_messages).to include("E page must be between StartPage to 9999")
      end
      it '学習終了ページが開始ページを超えていると登録できない' do
        @textbook.e_page = @textbook.s_page
        @textbook.valid?
        expect(@textbook.errors.full_messages).to include("E page must be between StartPage to 9999")
      end
    end
  end
end
