FactoryBot.define do
  factory :room_user do
    # associationを記載することで、定義したインスタンスも生成できる
    association :user
    association :room
  end
end