require 'rails_helper'

RSpec.describe DfTime, type: :model do
  before do
    @df_time = FactoryBot.build(:df_time)
  end

  describe '目標学習時間の登録' do
    context '目標学習時間が登録できるとき' do
      it '全ての項目が入力されていれば登録できる' do
        @df_time.valid?
        expect(@df_time).to be_valid
      end
    end
    context '目標学習時間が登録できないとき' do
      it 'いずれかの項目が空白の場合は登録できない' do
        @df_time.d_mon = ''
        @df_time.valid?
        expect(@df_time.errors.full_messages).to include("D mon can't be blank")
      end
      it 'いずれかの項目が0より少ない場合は登録できない' do
        @df_time.d_mon = -3
        @df_time.valid?
        expect(@df_time.errors.full_messages).to include('D mon must be greater than or equal to 0')
      end
      it 'いずれかの項目が23より大きい場合は登録できない' do
        @df_time.d_mon = 24
        @df_time.valid?
        expect(@df_time.errors.full_messages).to include('D mon must be less than or equal to 23')
      end
      it 'いずれかの項目が小数の場合は登録できない' do
        @df_time.d_mon = 10.1
        @df_time.valid?
        expect(@df_time.errors.full_messages).to include('D mon must be an integer')
      end
    end
  end
end
