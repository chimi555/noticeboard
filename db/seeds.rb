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

category1 = Category.create!(category_name: "ニュース")
category2 = Category.create!(category_name: "カルチャー")
category3 = Category.create!(category_name: "エンターテイメント")
category4 = Category.create!(category_name: "生活")

category5 = Category.create!(category_name: "書籍")
10.times do |n|
  user = User.first
  topic_title = "#{Faker::Book.title}"
  title = "#{topic_title}好きなみんな集まれ！"
  description = "#{topic_title}について語るスレです。"
  topic = Topic.create!(title: title, description: description, user_id: user.id, updated_at: n.day.ago.to_s)
  TopicCategory.create!(topic_id: topic.id, category_id: category1.id )
  TopicCategory.create!(topic_id: topic.id, category_id: category2.id )
  TopicCategory.create!(topic_id: topic.id, category_id: category5.id )
  content = "初めてのコメントです。(サンプルコメント)"
  comment = Comment.create!(content: content, user_id: user.id, topic_id: topic.id)
end

category6 = Category.create!(category_name: "映画")
15.times do |n|
  name = Faker::Name.name
  email = "example-#{n + 1}@example.com"
  password = 'password'
  user = User.create!(name: name,
                      email: email,
                      password: password,
                      password_confirmation: password
                      )
  topic_title = "#{Faker::Movie.quote}"
  title = "#{topic_title}について語りたい！"
  description = "#{topic_title}について語るスレです。"
  topic = Topic.create!(title: title, description: description, user_id: user.id, updated_at: n.day.ago.to_s)
  TopicCategory.create!(topic_id: topic.id, category_id: category1.id )
  TopicCategory.create!(topic_id: topic.id, category_id: category6.id )
  content = "初めてのコメントです。(サンプルコメント)"
  comment = Comment.create!(content: content, user_id: user.id, topic_id: topic.id)
end

category7 = Category.create!(category_name: "音楽")
13.times do |n|
  name = Faker::Name.name
  email = "example-#{n + 16}@example.com"
  password = 'password'
  user = User.create!(name: name,
                      email: email,
                      password: password,
                      password_confirmation: password
                      )
  topic_title = "#{Faker::Music.band}"
  title = "#{topic_title}好きなみんな集まれ！"
  description = "#{topic_title}好きが集まって好き勝手語るスレです。"
  topic = Topic.create!(title: title, description: description, user_id: user.id, updated_at: n.day.ago.to_s)
  TopicCategory.create!(topic_id: topic.id, category_id: category2.id )
  TopicCategory.create!(topic_id: topic.id, category_id: category3.id )
  TopicCategory.create!(topic_id: topic.id, category_id: category7.id )
  content = "初めてのコメントです。(サンプルコメント)"
  comment = Comment.create!(content: content, user_id: user.id, topic_id: topic.id)
end

category8 = Category.create!(category_name: "アーティスト")
10.times do |n|
  name = Faker::Name.name
  email = "example-#{n + 29}@example.com"
  password = 'password'
  user = User.create!(name: name,
                      email: email,
                      password: password,
                      password_confirmation: password
                      )
  topic_title = "#{Faker::Artist.name}"
  title = "#{topic_title}総合スレッド"
  description = "#{topic_title}について語りましょう！"
  topic = Topic.create!(title: title, description: description, user_id: user.id, updated_at: n.day.ago.to_s)
  TopicCategory.create!(topic_id: topic.id, category_id: category2.id )
  TopicCategory.create!(topic_id: topic.id, category_id: category3.id )
  TopicCategory.create!(topic_id: topic.id, category_id: category8.id )
  content = "初めてのコメントです。(サンプルコメント)"
  comment = Comment.create!(content: content, user_id: user.id, topic_id: topic.id)
end

category9 = Category.create!(category_name: "料理")
20.times do |n|
  name = Faker::Name.name
  email = "example-#{n + 39}@example.com"
  password = 'password'
  user = User.create!(name: name,
                      email: email,
                      password: password,
                      password_confirmation: password
                      )
  topic_title = "#{Faker::Food.dish}"
  title = "#{topic_title}"
  description = "#{topic_title}の作り方教えてください！"
  topic = Topic.create!(title: title, description: description, user_id: user.id, updated_at: n.day.ago.to_s)
  TopicCategory.create!(topic_id: topic.id, category_id: category4.id )
  TopicCategory.create!(topic_id: topic.id, category_id: category9.id )
  content = "初めてのコメントです。(サンプルコメント)"
  comment = Comment.create!(content: content, user_id: user.id, topic_id: topic.id)
end

80.times do |n|
  topic = Topic.find(rand(1..50))
  user = User.find(rand(1..30))
  content = "これはサンプルコメントです。" 
  comment = Comment.create!(content: content, user_id: user.id, topic_id: topic.id)
end
