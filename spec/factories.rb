Factory.define :user do |user|
  user.sequence(:username) {|n| "test_user_#{n}" }
  user.password 'password'
  user.password_confirmation 'password'
  user.sequence(:email) {|n| "test#{n}@example.com" }
end

Factory.define :post do |post|
  post.sequence(:title) {|n| "test_post_#{n}" }
  post.body 'This is a factory generated post body'
  post.sequence(:published_on) {|n| n.minutes.from_now}
  post.association :author, :factory => :user
end

Factory.define :photoalbum do |photoalbum|
  photoalbum.sequence(:name) {|n| "test_photoalbum_#{n}" }
  photoalbum.description "test_photoalbum description"
  photoalbum.association :author, :factory => :user
  photoalbum.sequence(:published_on) {|n| n.minutes.from_now}
end

Factory.define :picture do |picture|
  picture.sequence(:title) {|n| "test_picture_#{n}" }
  picture.picture { File.open("#{Rails.root}/features/support/images/picture.jpg") }
  picture.sequence(:published_on) {|n| n.minutes.from_now}
  picture.association :author, :factory => :user
  picture.association :photoalbum, :factory => :photoalbum
end

Factory.define :comment do |comment|
  comment.sequence(:body) {|n| "test_comment_#{n}" }
  comment.association :author, :factory => :user
  comment.association :commentable, :factory => :post
  comment.sequence(:created_at) {|n| n.minutes.from_now}
end
