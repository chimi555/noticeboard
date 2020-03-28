User.create!(
  name: 'テストユーザー',
  email: 'noticeboard@example.com',
  password: 'noticeboard',
  password_confirmation: 'noticeboard',
)

30.times do |n|
  name = Faker::Name.name
  email = "example-#{n + 1}@example.com"
  password = 'password'
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
              )
end