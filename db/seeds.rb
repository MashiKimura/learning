# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 5.times do |n|
#   User.create!(
#     email: "user#{n + 1}@example.com",
#     password: "#{n + 1}a123456",
#     nickname: "textuser#{n + 1}"
#   )
# end

# User.all.each do |user|
#   6.times do |n|
#     Textbook.create!(
#       book: "book_name#{user.id}_#{n + 1}",
#       s_page: 10 + (n + 1)
#       s_page: 200 + (n + 1)
#       user_id: user.id
#     )
#   end
# end

Textbook.all.each do |textbook|
  5.times do |n|
    Record.create!(
      r_date: Date.today.beginning_of_week + n,
      r_page: 20 + (n + 1),
      r_text: "testtesttest",
      textbook_id: textbook.id,
      hours: n + 1,
      minutes: (n + 1) * 10
    )
  end
  7.times do |n|
    Record.create!(
      r_date: Date.today.prev_week + n,
      r_page: 40 + (n + 1),
      r_text: "testtesttest",
      textbook_id: textbook.id,
      hours: n + 3,
      minutes: (n + 1) * 20
    )
  end
end