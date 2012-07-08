FactoryGirl.define do
  factory :user do
    sequence(:username)       { |n| "test_user_#{n}" }
    password                  'password'
    password_confirmation     { password }
    sequence(:email)          { |n| "test#{n}@example.com" }
  end

  factory :admin, :parent => :user do
    role                      'admin'
  end

  factory :oauth_user, :parent => :user do
    password                  nil
    password_confirmation     nil
    email                     nil
    authentications           { |authentications| [authentications.association(:authentication)] }
  end

  factory :authentication do
    association :user,        :factory => :user
    provider                  'twitter'
    sequence(:uid)            { |n| "oauth_uid_#{n}" }
  end

  factory :category do
    sequence(:name)           { |n| "test category #{n}" }
    association :author,     :factory => :admin
  end

  factory :content_block do
    sequence(:name)           { |n| "test_content_block_#{n}" }
  end

  factory :educational_qualification do
    name                      "Test Qualification"
    institution               "Test Institution"
    date_from                 2.years.ago.to_date
    date_to                   1.year.ago.to_date
  end

  factory :employment_history_item do
    company_name              "Test Company"
    company_role              "Company Role"
    date_from                 2.years.ago.to_date
    date_to                   1.year.ago.to_date
  end

  factory :photoalbum do
    sequence(:name)           { |n| "test photoalbum #{n}" }
    description               "test_photoalbum description"
    association :author,      :factory => :admin
    sequence(:published_on)   { |n| n.minutes.from_now }
  end

  factory :picture do
    sequence(:title)          { |n| "test picture #{n}" }
    picture                   { File.open("#{Rails.root}/spec/support/images/picture.jpg") }
    sequence(:published_on)   { |n| n.minutes.from_now}
    association :author,      :factory => :admin
    association :photoalbum,  :factory => :photoalbum
  end

  factory :post do
    sequence(:title)          { |n| "test post #{n}" }
    body                      'This is a factory generated post body'
    sequence(:published_on)   { |n| n.minutes.from_now }
    association :author,      :factory => :admin
    association :category,    :factory => :category
  end

  factory :portfolio_item do
    sequence(:title)          { |n| "test post #{n}" }
    description               'This is a factory generated portfolio item description'
    sequence(:published_on)   { |n| n.minutes.from_now }
    association :author,      :factory => :admin
    # port_item.association :category,                :factory => :category
  end

  factory :media_asset do
    sequence(:media_id)       { |n| "test_med_id#{n*20}"}
    association :owner,       :factory => :portfolio_item
  end
      factory :audio_asset, :class => "MediaAsset::AudioAsset", :parent => :media_asset do
        hosting_location_key      "soundcloud"
      end
      factory :video_asset, :class => "MediaAsset::VideoAsset", :parent => :media_asset do
        hosting_location_key      "vimeo"
      end

  factory :video_asset_with_splash, :parent => :video_asset do
    splash_image              { File.open("#{Rails.root}/spec/support/images/picture.jpg") }
  end

  factory :comment do
    sequence(:body)           { |n| "test comment #{n}" }
    association :author,      :factory => :user
    association :commentable, :factory => :post
    sequence(:created_at)     { |n| n.minutes.from_now }
  end
end