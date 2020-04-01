User.create!(
  name: 'テストユーザー',
  email: 'noticeboard@example.com',
  password: 'noticeboard',
  password_confirmation: 'noticeboard',
  role: :test
)

User.create!(
  name: 'adminユーザー',
  email: Rails.application.credentials.user[:admin_user_email] ,
  password: Rails.application.credentials.user[:admin_user_password],
  password_confirmation: Rails.application.credentials.user[:admin_user_password],
  role: :admin
)

30.times do |n|
  name = Faker::Name.name
  email = "example-#{n + 1}@example.com"
  password = 'password'
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password
              )
end

# Topic
users = User.order(:created_at).take(5)
10.times do
  title = "#{Faker::Book.title}好きなみんな集まれ！"
  description = "#{Faker::Book.title}について語るスレです。"
  users.each { |user| user.topics.create!(title: title, description: description) }
end