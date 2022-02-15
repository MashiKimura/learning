require 'rails_helper'

RSpec.describe Record, type: :model do
  before do
    @textbook = FactoryBot.create(:textbook)
    @record = FactoryBot.build(:record, textbook_id: @textbook.id)
    sleep 0.1
  end

  describe '学習記録登録' do
    context '学習記録が登録できる時' do
      it '全ての項目が入力されていれば登録できる' do
        @record.valid?
        expect(@record).to be_valid
      end
      it 'コメントが空白でも登録できる' do
        @record.r_text = ''
        @record.valid?
        expect(@record).to be_valid
      end
      it '時間が0でも、分が適当であれば登録できる' do
        @record.hours = 0
        @record.valid?
        expect(@record).to be_valid
      end
      it '分が0でも、時間が適当であれば登録できる' do
        @record.minutes = 0
        @record.valid?
        expect(@record).to be_valid
      end
    end
    context '学習記録が登録できないとき' do
      it '日付が空白では登録できない' do
        @record.r_date = ''
        @record.valid?
        expect(@record.errors.full_messages).to include("R date can't be blank")
      end
      it '学習時間、時間と分が空白では登録できない' do
        @record.hours = ''
        @record.minutes = ''
        @record.valid?
        expect(@record.errors.full_messages).to include('Hours is not a number')
      end
      it '時間と分の両方が0では登録できない' do
        @record.hours = 0
        @record.minutes = 0
        @record.valid?
        expect(@record.errors.full_messages).to include("Hours and Minutes be can't blank")
      end
      it '時間がマイナスでは登録できない' do
        @record.hours = -1
        @record.valid?
        expect(@record.errors.full_messages).to include('Hours must be greater than or equal to 0')
      end
      it '分がマイナスでは登録できない' do
        @record.minutes = -30
        @record.valid?
        expect(@record.errors.full_messages).to include('Minutes must be greater than or equal to 0')
      end
      it '時間が24以上では登録できない' do
        @record.hours = 24
        @record.valid?
        expect(@record.errors.full_messages).to include('Hours must be less than or equal to 23')
      end
      it '分が60以上では登録できない' do
        @record.minutes = 60
        @record.valid?
        expect(@record.errors.full_messages).to include('Minutes must be less than or equal to 59')
      end
      it '時間が小数では登録できない' do
        @record.hours = 10.1
        @record.valid?
        expect(@record.errors.full_messages).to include('Hours must be an integer')
      end
      it '分が小数では登録できない' do
        @record.minutes = 10.1
        @record.valid?
        expect(@record.errors.full_messages).to include('Minutes must be an integer')
      end
      # it '終了ページが空白では登録できない' do
      #   @record.r_page = ""
      #   @record.valid?
      #   expect(@record.errors.full_messages).to include("R page can't be blank")
      # end
      it '終了ページが教材の0だと登録できない' do
        @record.r_page = 0
        @record.valid?
        expect(@record.errors.full_messages).to include('R page must be between start and end')
      end
      it '終了ページが教材の開始ページ以下だと登録できない' do
        @record.r_page = @textbook.s_page
        @record.valid?
        expect(@record.errors.full_messages).to include('R page must be between start and end')
      end
      it '終了ページが教材の終了ページ以上だと登録できない' do
        @record.r_page = @textbook.e_page
        @record.valid?
        expect(@record.errors.full_messages).to include('R page must be between start and end')
      end
      it '終了ページが小数では登録できない' do
        @record.r_page = 10.1
        @record.valid?
        expect(@record.errors.full_messages).to include('R page must be an integer')
      end
      it 'コメントは150文字を超えた場合には登録できない' do
        @record.r_text = Faker::Lorem.characters(number: 151)
        @record.valid?
        expect(@record.errors.full_messages).to include('R text is too long (maximum is 150 characters)')
      end
    end
  end
end
