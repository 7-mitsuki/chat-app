require 'rails_helper'

# モデルのテストは、要素が欠けていた場合に保存できるかできないか。の観点からチェックを行う
RSpec.describe Room, type: :model do
  before do
    @room = FactoryBot.build(:room)
  end

  describe 'チャットルーム作成' do
    context '新規登録できる場合' do
      it 'nameの値が存在すれば作成できる' do
        expect(@room).to be_valid
      end
    end
    context '新規登録できない場合' do
      it 'nameの値が空では作成できない' do
        @room.name = ''
        @room.valid?
        expect(@room.errors.full_messages).to include("Name can't be blank")
      end
    end
  end
end
