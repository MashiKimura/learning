FactoryBot.define do
  factory :textbook do
    book          { Faker::Lorem.word }
    s_page        { Faker::Number.between(from: 1, to: 999) }
    e_page        { s_page + Faker::Number.between(from: 1, to: 9_000) }
    association   :user

    after(:build) do |textbook|
      textbook.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
