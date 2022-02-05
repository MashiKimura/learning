FactoryBot.define do
  factory :record do
    r_date      {Faker::Date.between(from: '2020-01-01', to: '2021-12-31')}
    r_page      {Faker::Number.between(from: Textbook.find(textbook_id).s_page, to: Textbook.find(textbook_id).e_page)}
    r_text      {Faker::Lorem.sentence}
    hours       {Faker::Number.between(from: 0, to: 23)}
    minutes     {Faker::Number.between(from: 0, to: 59)}
    association :textbook
  end
end
