FactoryBot.define do
  factory :df_time do
    d_sun       {Faker::Number.between(from: 0, to: 23)}
    d_mon       {Faker::Number.between(from: 0, to: 23)}
    d_tue       {Faker::Number.between(from: 0, to: 23)}
    d_wed       {Faker::Number.between(from: 0, to: 23)}
    d_thu       {Faker::Number.between(from: 0, to: 23)}
    d_fri       {Faker::Number.between(from: 0, to: 23)}
    d_sat       {Faker::Number.between(from: 0, to: 23)}
    association :textbook
  end
end
